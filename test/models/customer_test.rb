require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  describe "Customer validations" do
    it "Customer must have a name and phone number" do
      # go through a loop that will check that everything is present
      customer = customers(:one)
      customer.valid?.must_equal true
    end

    it "Customer is not valid without a name" do
      customer = customers(:two)
      customer.name = nil
      customer.valid?.must_equal false
    end

    it "Customer is not valid without a phone number" do
      customer = customers(:three)
      customer.phone = nil
      customer.valid?.must_equal false
    end
  end
  describe "Customer relationships" do
    it "Customer can have many rentals" do
      customer = customers(:two)
      # rental one must have customer two
      customer.rentals.must_include rentals(:one)
    end
  end
end
# customer = Customer.new
# customer.validate .... this probably isn't right
# Create keys that we are requiring for customers
# customer.each.keys do |key|
#
# end
