require "test_helper"

describe Customer do
  describe "validations" do
    it "can call movies from customers" do
      customer = customers(:shelley)
      customer.must_respond_to :movies
      customer.movies.first.must_be_kind_of Movie
    end

    it "can call rentals from customers" do
      customer = customers(:shelley)
      customer.must_respond_to :rentals
      customer.rentals.first.must_be_kind_of Rental
    end
  end
end
