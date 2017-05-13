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

  describe "overdue?" do
    it "returns true if rental is overdue" do
      rental = rentals(:rental_overdue)
      rental.overdue?.must_equal true
    end

    it "returns false if rental is not overdue" do
      rental = rentals(:rental_one)
      rental.overdue?.must_equal false
    end
  end

  describe "self.list_of_overdue" do
    it "returns an array" do
      Rental.list_of_overdue.must_be_kind_of Array
    end

    it "all objects in array are Rentals & overdue" do
      list = Rental.list_of_overdue
      list.each do |rental|
        rental.must_be_kind_of Rental
        rental.overdue?.must_equal true
      end
    end

    it "if no overdue rentals returns empty array" do
      Rental.destroy_all
      Rental.list_of_overdue.must_equal []
    end


  end
end
