require "test_helper"

describe RentalsController do

  describe "index" do
    # each customer in the response body should have the following keys
    CUSTOMER_KEYS = %w( customer_id name postal_code rentals )
    # each rental in the rentals key/value pair (value is an array of rentals) has these three keys
    RENTAL_KEYS = %w( created_at duedate title )

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

  end

  describe "update" do
    it "must have customer_id" do

    end

    it "must have title" do

    end

    it "returns a confirmation hash" do
      # what should this look like?
    end

    it "resets duedate to nil"

  end

end
