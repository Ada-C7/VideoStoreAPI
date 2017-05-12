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

  describe "check-in" do
    let(:rental_data) {
      {customer_id: customers(:one).id,
      due_date: "2017-05-13"}
    }

    it "can return a movie" do
      post check_out_path(movies(:three).title), params: { rental: rental_data }
      proc {
        post check_in_path(movies(:three).title), params: { rental: { customer_id: rental_data[:customer_id] } }
      }.wont_change 'Rental.count'

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_include "id"
      body.must_include "check_in"

      Rental.last.check_in.wont_be_nil
    end

    it "available inventory goes up by one after check in" do
      post check_out_path(movies(:three).title), params: { rental: rental_data }

      proc {
        post check_in_path(movies(:three).title), params: { rental: { customer_id: rental_data[:customer_id] } }
      }.must_change 'movies(:three).available_inventory', 1
    end

    it "cannot check in a movie that hasn't been checked out" do
      proc {
        post check_in_path(movies(:three).title), params: { rental: { customer_id: rental_data[:customer_id] } }
      }.wont_change 'movies(:three).available_inventory'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"].must_equal "This customer does not have this movie checked out."
    end

    it "cannot check in a movie that's checked out by a different customer" do
      proc {
        post check_in_path(movies(:two).title), params: { rental: { customer_id: customers(:three).id } }
      }.wont_change 'movies(:two).available_inventory'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"].must_equal "This customer does not have this movie checked out."
    end

    it "cannot check in a movie that doesn't exist" do
      post check_in_path("MOVIE THAT DOESN'T EXIST"), params: { rental: { customer_id: customers(:three).id } }
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"].must_equal "Sorry we do not currently carry MOVIE THAT DOESN'T EXIST"
    end

    it "if customer has same movie checked out more than once, it only checks in once" do
      proc {
        post check_out_path(movies(:one).title), params: { rental: rental_data }
        rental_data[:due_date] = "2017-05-31"
        post check_out_path(movies(:one).title), params: { rental: rental_data }
      }.must_change 'movies(:one).available_inventory', -2

      proc {
        post check_in_path(movies(:one).title), params: { rental: { customer_id: customers(:one).id } }
      }.must_change 'movies(:one).available_inventory', 1
    end
  end

end
