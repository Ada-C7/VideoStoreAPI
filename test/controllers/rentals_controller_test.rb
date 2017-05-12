require "test_helper"

describe RentalsController do


  describe "check-out" do

    let(:rental_data) {
      {customer_id: customers(:one).id,
      due_date: "2017-05-13"}
    }

    it " Can check out a movie" do

      proc {
        post check_out_path( movies(:one).title), params: { rental: rental_data }
      }.must_change 'Rental.count', 1

      must_respond_with :success

      Rental.last.customer_id.must_equal rental_data[:customer_id]
      Rental.last.due_date.must_equal DateTime.parse(rental_data[:due_date])
      Rental.last.check_out.wont_be_nil
      Rental.last.movie.must_equal movies(:one)
    end

    it "available_inventory is adjusted when movie is checked out" do
      proc {
        post check_out_path( movies(:one).title), params: { rental: rental_data }
      }.must_change 'movies(:one).available_inventory', -1

    end

    it " Won't change rental count if missing required params " do
      rental_data[:due_date] = nil

      proc {
        post check_out_path( movies(:one).title), params: { rental: rental_data }
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_include "errors"
      body['errors'].must_include "due_date"
    end

    it " Retuns bad_request if given a movie that doesn't exist " do

      proc {
        post check_out_path( "Mean Girls"), params: { rental: rental_data }
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_include "errors"
      body['errors'].must_equal "Sorry we do not currently carry Mean Girls"
    end

    it " Won't change rental count if available_inventory is 0 " do

      proc {
        post check_out_path( movies(:four).title), params: { rental: rental_data }
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_include "errors"
      body['errors'].must_equal "Sorry, #{movies(:four).title} is not available at this moment"
      movies(:four).available_inventory.must_equal 0
    end
  end

end
