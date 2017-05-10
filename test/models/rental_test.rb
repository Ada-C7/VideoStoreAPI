require "test_helper"

describe Rental do

  describe "validations for rental" do
    it "requires a due date" do
      rental = rentals(:one)
      puts rental.errors.messages
      rental.valid?.must_equal true

      rental = Rental.new(customer: customers(:one), movie: movies(:one))
      rental.valid?.must_equal false
      rental.errors.messages.must_include :due_date

    end

    it "requires a due date after today" do

    end

    it "due date must be a Date object" do

    end

    it "requires a returned field" do

    end

    it "returned is set to false" do

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
end
