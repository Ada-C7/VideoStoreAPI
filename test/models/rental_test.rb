require "test_helper"

describe Rental do

  describe "Relationships" do

    it "must belong to a movie" do
      rental = rentals(:rental_one)
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
    end

    it "must belong to a customer" do
      rental = rentals(:rental_one)
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
    end

  end

end
