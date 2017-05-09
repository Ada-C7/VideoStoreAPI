require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "Customer must have a name and phone number" do
    customer = Customer.new
    customer.valid?.must_equal false
    customer.errors.messages.must_include :name
    customer.errors.messages.must_include :phone
    #value(customer).must_be :valid?
  end

  it "Is valid if Customer has name and phone number" do
    customer = Customer.new
    customer.name = "Bob"
    customer.phone = "808-123-4567"
    customer.save
    customer.valid?.must_equal true
    customer.errors.messages.count.must_equal 0
  end

  it "postal_code must be five digits" do
    customer = customers(:mary)
    # customer.postal_code.valid?.must_equal true

    customer2 = Customer.new
    customer2.name = "Bob"
    customer2.postal_code = "4383972"
    customer2.valid?.must_equal false
  end

end
