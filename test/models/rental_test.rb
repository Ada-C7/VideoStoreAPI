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
  end

end
