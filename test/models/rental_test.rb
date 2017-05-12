require "test_helper"

describe Rental do
  describe "relationships" do
    it "belongs to a customer" do
      # ar = Rental.reflect_on_association(:customers)
      # ar.macro.must_equal :belongs_to
      rental = rentals(:one)
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
    end

    it "belongs to a movie" do
      rental = rentals(:one)
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
    end
  end

  describe "Validations" do
    it "checks the presence of due_date" do
      rental = Rental.create
      result = rental.valid?
      result.must_equal false
      rental.errors.messages.must_include :due_date
    end
  end

end
