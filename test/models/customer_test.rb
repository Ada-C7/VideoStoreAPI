require "test_helper"

describe Customer do
  let(:new_customer) { Customer.new }

  REQUIRED_FIELDS = %w(name registered_at address city state postal_code phone account_credit)

  describe "Customer validations" do
    it "Customer must have a name and phone number" do
      customer = customers(:one)
      customer.valid?.must_equal true
    end

    REQUIRED_FIELDS.each do |field|
      it "Customer is not valid when #{field} is not present" do
        new_customer.valid?.must_equal false
        new_customer.errors.messages.must_include field.to_sym
      end
    end

    it "Customer is not valid if account_credit is not a number" do
      customer = customers(:one)
      customer.account_credit = "wrong"
      customer.valid?.must_equal false
      customer.errors.messages.must_equal :account_credit => ["is not a number"]
    end
  end

  describe "Customer relationships" do
    it "Customer can have many rentals" do
      customer = customers(:three)
      customer.rentals.must_include rentals(:one)
    end
  end
end
