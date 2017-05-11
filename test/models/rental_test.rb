require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "requires a movie, customer and due date to create" do
    rental.valid?.must_equal false
  end

  it "can be created with valid customer, movie and due date" do
    rental.customer = customers(:one)
    rental.movie = movies(:one)
    rental.due_date = "1/1/18"

    rental.save.must_equal true
  end

  describe "Rental#Overdue" do
    it "should return an array of rentals" do
      rentals = Rental.overdue
      rentals.must_be_instance_of Array
      rentals.each do |rental|
        rental.must_be_instance_of Rental
      end
    end

    it "Each rental's due date should be past today's date" do
      skip
    end

    it "If there are no overdue rentals, should return an empty array" do
      skip
    end

    it "If a rental's due date is today, should not be returned" do
      skip
    end
  end
end
