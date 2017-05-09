require "test_helper"

describe Customer do
  describe "validations" do
  # let(:customer) { Customer.new }

    it "you can create a customer" do
      customer = Customer.new
      customer.valid?.must_equal true
    end

    it "won't create customer without name" do
      customer = customers(:bare_minimum)
      customer.name = ""

      customer.valid?.must_equal false
      customer.errors.messages.must_include :name
    end

    it "won't create customer without registered_at" do
      customer = customers(:bare_minimum)
      customer.registered_at = ""

      customer.valid?.must_equal false
      customer.errors.messages.must_include :registered_at
    end

    it "won't create customer without postal_code" do
      customer = customers(:bare_minimum)
      customer.postal_code = ""

      customer.valid?.must_equal false
      customer.errors.messages.must_include :postal_code
    end

    it "won't create customer without phone" do
      customer = customers(:bare_minimum)
      customer.phone = ""

      customer.valid?.must_equal false
      customer.errors.messages.must_include :phone
    end

    it "won't create customer without movies_checked_out_count" do
      customer = customers(:bare_minimum)
      customer.movies_checked_out_count = nil

      customer.valid?.must_equal false
      customer.errors.messages.must_include :movies_checked_out_count
    end

    it "creates customer without address" do
      customer = customers("has_all")
      customer.address = ""
      customer.valid?.must_equal true
    end

    it "creates customer without city" do
      customer = customers("has_all")
      customer.city = ""
      customer.valid?.must_equal true
    end

    it "creates customer without state" do
      customer = customers("has_all")
      customer.state = ""
      customer.valid?.must_equal true
    end
  end
end
