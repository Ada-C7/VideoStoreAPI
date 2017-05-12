require "test_helper"

describe Rental do
  describe "relations" do
    it "has a movie" do
      r = rentals(:one)
      r.must_respond_to :movie
      r.movie.must_be_kind_of Movie
    end

    it "has a customer" do
      r = rentals(:one)
      r.must_respond_to :customer
      r.customer.must_be_kind_of Customer
    end
  end

  describe "validations" do

  end
end
