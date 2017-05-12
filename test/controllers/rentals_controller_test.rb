require "test_helper"

describe RentalsController do
  describe "create" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        due_date: "2017-06-30"
      }
    }

    it "Creates a new rental" do
      proc {
        post check_out_path(movies(:one).title), params: { rental: rental_data }
      }.must_change 'Rental.count', 1
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      # Check that the ID matches
      Rental.find(body["id"]).movie.title.must_equal movies(:one).title
      Rental.find(body["id"]).customer_id.must_equal rental_data[:customer_id]
      Rental.find(body["id"]).due_date.must_equal Date.parse(rental_data[:due_date])
    end

    # may need more tests for cases: missing customer, missing duedate
    it "Returns an error for an incorrect title" do
      proc {
        post check_out_path("jaws"), params: { rental: rental_data }
      }.wont_change 'Rental.count'
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "movie"
      body.must_equal "errors" => {"movie" => ["must exist"]}
    end

    it "Returns an error for a missing customer" do
      bad_data = rental_data.clone()
      bad_data.delete(:customer_id)
      proc {
        post check_out_path(movies(:one).title), params: { rental: bad_data }
      }.wont_change 'Rental.count'
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "customer"
      body.must_equal "errors" => {"customer" => ["must exist"]}
    end

    it "returns an error if there is not enough inventory" do
      proc {
        post check_out_path(movies(:three).title), params: { rental: rental_data }
      }.wont_change 'Rental.count'

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "availability"
      body.must_equal "errors" => {"availability" => ["Sorry, this movie is not in stock"]}
    end
  end


  describe "update (check in a movie)" do
    it "should change returned field to true when a movie is checked in" do

      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:one)} }
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "movie_returned"
    end

    it "checking in a movie should increase its available inventory by one" do
      available_inventory = movies(:one).available_inventory
      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:one)} }
      movies(:one).available_inventory.must_equal (available_inventory + 1)
    end

    it "checking in a movie decreases the customer's movies_checked_out_count" do
      movies_checked_out = customers(:one).movies_checked_out_count
      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:one)} }
      customers(:one).movies_checked_out_count.must_equal (movies_checked_out + 1)
    end

    it "returns an error if the movie has already been checked in" do

      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:one)} }
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "movie_returned"


      available_inventory = movies(:one).available_inventory
      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:one)} }
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_equal "errors" => {"check-in" => ["Customer has already checked in this movie"]}
      available_inventory = movies(:one).available_inventory

    end

    it "returns an error if the customer has not checked out the movie" do
      movie_count = customers(:one).movies_checked_out_count
      post check_in_path(movies(:two).title), params: { rental: {customer_id: customers(:one)} }
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_equal "errors" => {"check-in" => ["Customer has not checked out this movie"]}
      customers(:one).movies_checked_out_count.must_equal movie_count
    end

  end
  it "should get overdue" do
    skip
    get rentals_overdue_url
    value(response).must_be :success?
  end

end
