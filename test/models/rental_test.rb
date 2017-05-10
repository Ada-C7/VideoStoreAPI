require "test_helper"

describe Rental do

  describe "validations for rental" do
    it "requires a due date" do
      rental = rentals(:one)
      rental.valid?.must_equal true

      rental = Rental.new(customer: customers(:one), movie: movies(:one))
      rental.valid?.must_equal false
      rental.errors.messages.must_include :due_date

      rental = Rental.new(customer: customers(:one), movie: movies(:one), due_date: "2017")
      rental.valid?.must_equal false
      rental.errors.messages[:due_date].must_include "date must be in YYYY-MM-DD format"
    end

    it "requires a due date after today" do
      rental = Rental.new(customer: customers(:one), movie: movies(:one), due_date: "2016-04-13")
      rental.valid?.must_equal false
      rental.errors.messages[:due_date].must_equal ["due date must be after today"]
    end

    it "due date must be a Date object" do
      
    end

    it "requires a returned field" do

    end

    it "returned is set to false" do

    end
end

    describe "relationships" do
      it "requires a customer" do

      end

      it "requires a movie" do

      end

      it "can get the customer" do
      end

      it "can get the movie" do

      end

    end

end
