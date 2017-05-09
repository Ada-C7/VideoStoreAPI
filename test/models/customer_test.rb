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

    it "can't create a customer with phone number that's already in database" do
      customer_1 = customers(:aj)
      customer_2 = customer_1.dup

      customer_2.valid?.must_equal false
      customer_2.errors.messages.must_include :phone
    end
  end

  describe "movies_checked_out_count" do
    # TODO: Create movie checkout relationship and write method
    it "returns 0" do
      customers(:aj).movies_checked_out_count.must_equal 0
    end
  end
end
