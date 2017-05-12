require "test_helper"

describe RentalsController do

  describe "index" do
    # each customer in the response body should have the following keys
    CUSTOMER_KEYS = %w( customer_id name postal_code rentals )
    # each rental in the rentals key/value pair (value is an array of rentals) has these three keys
    RENTAL_KEYS = %w( created_at duedate title )

    it "is a real working route" do
      get overdue_path
      must_respond_with :success
    end

    it "returns a json" do
      get overdue_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get overdue_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "can get a list of customers" do

    end

    it "customers each have the CUSTOMER_KEYS" do

    end

    it "all customers have at least one rental in their rentals array" do

    end

    it "all rentals have the RENTAL_KEYS" do

    end

    it "all rentals in each customer's rentals array are overdue" do

    end

    it "returns a specific message if no overdue rentals" do

    end

  end

  describe "create" do
    it "must have title" do

    end

    it "must have customer_id" do

    end

    it "must have duedate" do

    end

    it "updates the available inventory for the assoc. movie" do

    end

    it "returns a confirmation hash" do
      # what should this look like?
    end

    it "failure to checkout movie returns an appropriate error" do
      # what should this be?
    end

  end

  describe "update" do
    it "must have customer_id" do

    end

    it "must have title" do

    end

    it "returns a confirmation hash" do
      # what should this look like?
    end

    it "returned is now true" do

    end

    it "updates the movie's available_inventory" do
      # use a proc to check the change of the number?
    end

    it "if checking fails returns an error message" do
      # what should it be?
    end

  end

end
