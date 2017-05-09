require "test_helper"

describe Customer do
  describe "validations" do
    it "won't create a customer without parameters" do
      required_attributes = [ :name, :registered_at, :address, :city, :state, :postal_code, :phone ]
      customer = Customer.new
      customer.valid?.must_equal false
      required_attributes.each do |attribute|
        customer.errors.messages.must_include attribute
      end
    end

    it "can create a customer with valid parameters" do
      customers(:aj).valid?.must_equal true
    end
  end
end
