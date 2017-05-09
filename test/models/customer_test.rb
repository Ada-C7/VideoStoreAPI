require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  describe "Customer validations" do
    it "Customer must have a name and phone number" do
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
end
