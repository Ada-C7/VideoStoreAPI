require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  describe "validations" do
    it "creates a rental" do
      rental = rentals(:rental_one)
      rental.valid?.must_equal true
    end

    it "won't create rental without duedate" do
      rental = rentals(:rental_two)
      rental.duedate = nil
      rental.valid?.must_equal false
      rental.errors.messages.must_include :duedate
    end
  end

  describe "relationships" do
    it "has a customer" do
      rental = rentals(:rental_one)
      rental.customer.must_equal customers(:has_all)

      rental.customer = customers(:bare_minimum)
      rental.customer.must_equal customers(:bare_minimum)
    end

    it "has a movie" do
      rental = rentals(:rental_two)
      rental.movie.must_equal movies(:heat)

      rental.movie = movies(:dumbo)
      rental.movie.must_equal movies(:dumbo)

    end
  end
end
