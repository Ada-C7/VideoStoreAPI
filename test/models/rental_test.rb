require "test_helper"

describe Rental do
  describe "validations" do
    it "cannot create rental without parameters" do
      required_attributes = [:due_date, :customer, :movie]
      rental = Rental.new
      rental.valid?.must_equal false
      required_attributes.each do |attribute|
        rental.errors.messages.must_include attribute
      end
    end

    it "can create a rental with valid parameters" do
      rentals(:one).valid?.must_equal true
    end

    it "does not allow a due date with an inappropriate format" do
      invalid_rental = Rental.new(due_date: "05-22-2016", customer: customers(:aj), movie: movies(:star_wars))
      invalid_rental.valid?.must_equal false
      invalid_rental.errors.messages.must_include :due_date
    end
  end

  describe "checkout_date" do
    it "creates a checkout date equal to the creation date" do
      rentals(:one).checkout_date.must_equal rentals(:one).created_at.strftime("%F")
    end
  end

end
