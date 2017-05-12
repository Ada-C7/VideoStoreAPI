require "test_helper"

describe RentalsController do
  describe "checkout" do

    it "returns a json object" do
      customer_id = customers(:alison).id
      post checkout_path("Doctor Strange"), params: { rental: {customer_id: customer_id } }
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'id'

      Rental.find(body['id']).customer_id.must_equal customer_id
    end

    it "creates a new rental" do
      proc {
        post checkout_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
      }.must_change 'Rental.count', 1
      must_respond_with :success
    end

    #rental has all the correct fields - movie, customer, checkout date, due date, checkout status of true
    it "has the correct movie, customer, checkout date, due date (a week away), checkout status of true" do
      movie_title = "Doctor Strange"
      customer_id = customers(:brenna).id

      post checkout_path(movie_title), params: { rental: { customer_id: customer_id } }
      rental = Rental.last
      rental.movie.title.must_equal movie_title
      rental.customer_id.must_equal customer_id
      rental.checkout_date.must_equal Date.today.strftime("%Y-%m-%d")
      rental.due_date.must_equal (Date.today + 7).strftime("%Y-%m-%d")
      rental.checked_out.must_equal true
    end

    it "changes the movie model's available_inventory when the movie is rented" do
      post checkout_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
      Rental.last.movie.available_inventory.must_equal 49
    end

    it "fails to create a rental with invalid input" do
      proc {
        post checkout_path("Doctor Strange"), params: { rental: { customer_id: -4 } }
      }.wont_change 'Rental.count'
      must_respond_with :bad_request
    end
  end

  describe "checkin" do
    # changes rental status

    #
  end

  describe "overdue" do
    # gets overdue rentals

    # works if no overdue rentals

    # all rentals in list are past due
  end
end
