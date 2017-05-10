require "test_helper"

describe Customer do
  let(:customer) {customers(:shelley)}

  describe "validations" do
    it "can call movies from customers" do
      customer.must_respond_to :movies
      customer.movies.first.must_be_kind_of Movie
    end

    it "can call rentals from customers" do
      customer.must_respond_to :rentals
      customer.rentals.first.must_be_kind_of Rental
    end
  end

  describe "movies_checked_out" do
    it "returns the number of movies checkout out to a customer" do
      number = customer.movies_checked_out
      number.must_equal 1
    end

    it "returns 0 if  customer has no movies checked out" do
      rental = rentals(:one)
      rental.checked_out = false
      rental.save
      number = customer.movies_checked_out
      number.must_equal 0
    end
  end

end
