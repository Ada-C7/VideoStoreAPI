require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  describe "Customer validations" do
    it "Customer must have a name and phone number" do
      customer = customers(:one)
      customer.valid?.must_equal true
    end

    it "Customer is not valid without a name" do 
    end

    it "Customer is not valid without a phone number" do
    end
  end
end
