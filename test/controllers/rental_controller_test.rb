require "test_helper"

describe RentalController do

  let (:rental) { Rental.new(
    due_date: "12/03/12",
    movie_id: 2,
    customer_id: 2,
    )
  }

  describe "rentals#overdue" do

    before do
      get overdue_path
    end

    it "should get overdue" do
      value(response).must_be :success?
    end


  end

  describe "rentals#checkout" do

    before do
      post checkout_path()
    end

    it "should get checkout" do
      value(response).must_be :success?
    end

  end

  describe "rentals#checkin" do

    before do
      post checkin_path
    end

    it "should get checkin" do
      value(response).must_be :success?
    end

    it "should change the "

  end

end
