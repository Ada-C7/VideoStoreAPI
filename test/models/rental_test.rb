require "test_helper"

describe Rental do
  describe "validations" do
    it "cannot create rental without parameters" do
      required_attributes = [:checkout_date, :customer, :movie]
      rental = Rental.new
      rental.valid?.must_equal false
      required_attributes.each do |attribute|
        rental.errors.messages.must_include attribute
      end
    end

    it "can create a rental with valid parameters" do
      rentals(:one).valid?.must_equal true
    end

    it "cannot create rental with invalid checkout date format" do
      bad_rental = Rental.new(checkout_date: "05-13-2017", customer: customers(:aj), movie: movies(:star_wars))
      bad_rental.valid?.must_equal false
    end
  end

  describe "due_date" do
    it "calculates the due date on initialization" do
      expected_due_date = "2017-05-13"
      rentals(:one).due_date.must_equal expected_due_date
    end
  end

end
