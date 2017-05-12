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
      rental = Rental.create(movie_id: movies(:one).id, customer_id: customers(:three).id, due_date: "2018-10-10")

      rental.returned.must_equal false
      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:three).id} }
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "movie_returned"
      rental.reload
      rental.returned.must_equal true

    end

    it "checking in a movie should increase its available inventory by one" do
      #working
      proc { post check_in_path(movies(:one).title), params:
        { rental: {customer_id: customers(:one).id} }
      }.must_change 'movies(:one).available_inventory', 1

    end

    it "checking in a movie decreases the customer's movies_checked_out_count" do
      ada = Customer.create(name: "Ada Ada", phone: "617-6176-6170")

      Rental.create(movie_id: movies(:one).id, customer_id: ada.id, due_date: "2018-10-10")

      movies_checked_out = ada.movies_checked_out_count

      post check_in_path(movies(:one).title), params: { rental: {customer_id: ada.id}}

      ada.reload
      ada.movies_checked_out_count.must_equal movies_checked_out - 1

    end

    it "returns an error if the movie has already been checked in" do

      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:one).id} }
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "movie_returned"


      available_inventory = movies(:one).available_inventory
      post check_in_path(movies(:one).title), params: { rental: {customer_id: customers(:one).id} }
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_equal "errors" => {"check_in" => "Customer has already checked in this movie"}
      available_inventory = movies(:one).available_inventory


    end

    it "returns an error if the customer has not checked out the movie" do
      proc {
      movie_count = customers(:one).movies_checked_out_count
      post check_in_path(movies(:two).title), params: { rental: {customer_id: customers(:one)} }
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_equal "errors" => {"check_in" => "Cannot find this rental"}
      customers(:one).movies_checked_out_count.must_equal movie_count
      }
    end

  end
  it "should get overdue" do
    skip
    get rentals_overdue_url
    value(response).must_be :success?
  end

end
