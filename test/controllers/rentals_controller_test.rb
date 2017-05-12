require "test_helper"

describe RentalsController do
    let(:rental_data) {
  { movie_id: movies(:one),
    customer_id: customers(:three).id,
    due_date: '2017-05-05'
  }
  }

  describe "Checkout" do

    it "Creates a new rental recod" do
      proc {
        post checkout_path(movies(:one).title), params: {customer_id: customers(:three).id, movie_id: movies(:two).id, due_date: '2017-6-10'
        }
      }.must_change "Rental.count", 1
      must_respond_with :success
    end

    # it "Can checout a movie" do
    #   rental = rentals(:one)
    #   rental.checlout
    #   rental.
    # end

    it "Won't checkout a movie if a movie doesn't exit" do
      proc {
        post checkout_path(title: "not_found"), params: rental_data
      }.must_change "Rental.count",0

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"].must_equal "title" => ["Movie 'not_found' not found"]
    end

    it "Gives error message if due_date was missing" do
      proc{
        post checkout_path(movies(:one).title), params: {customer_id: customers(:three).id, movie_id: movies(:two).id }

      }.must_change "Rental.count", 0
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"due_date" => ["can't be blank"]}
    end
  end

end
