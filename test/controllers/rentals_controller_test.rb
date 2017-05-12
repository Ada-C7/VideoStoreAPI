require "test_helper"

describe RentalsController do
  describe "checkout" do

    it "returns a json object" do
        post checkout_path("Doctor Strange"), params: { rental: {customer_id: 1} } 
        response.header['Content-Type'].must_include 'json'
    end
    # rental with id of rental
    #creates a new rental
    #rental has all the correct fields - movie, customer, checkout date, due date, checkout status of true
    #fails to create rental with invalid data
    #check that it is affecting the movie model (available_inventory)


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
