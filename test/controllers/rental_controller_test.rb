require "test_helper"

describe RentalController do

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
      get checkout_path(title: "Lion King")
    end

    it "should get checkout" do
      value(response).must_be :success?
    end

  end

  describe "rentals#checkin" do

    before do
      get checkin_path
    end

    it "should get checkin" do
      value(response).must_be :success?
    end

  end

end
