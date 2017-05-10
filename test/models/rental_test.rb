require "test_helper"

describe Rental do
  describe "validations" do
    it "cannot create rental without parameters" do
      required_attributes = [:customer, :movie]
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

  describe "due_date" do
    it "calculates the appropriate due date on initialization as 3 days after" do
      expected_due_date = Date.today.+(3).strftime("%F")
      rentals(:one).due_date.must_equal expected_due_date
    end
  end

  describe "checkout_date" do
    it "creates a checkout date equal to the creation date" do
      rentals(:one).checkout_date.must_equal rentals(:one).created_at.strftime("%F")
    end
  end

end
