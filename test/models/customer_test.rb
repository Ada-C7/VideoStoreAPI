require "test_helper"

describe Customer do
  # let(:customer) { Customer.new }
  #
  # it "must be valid" do
  #   value(customer).must_be :valid?
  # end
describe "validations" do
  it "must have a name" do
    customer = Customer.new(address: "234 flower street", phone: "000-768-6252", registered_at: "some time")
    customer.valid?.must_equal false
    customer.errors.messages.must_include :name

  end

  it "name must be a string" do
    customer = Customer.new(name: 212, address: "234 flower street", phone: "000-768-6252", registered_at: "some time")
    customer.valid?.must_equal false
    customer.errors.messages.must_include :name
    
  end

  it "must have a street address" do
    customer = Customer.new(name: "Anna", phone: "000-768-6252", registered_at: "some time")
    customer.valid?.must_equal false
    customer.errors.messages.must_include :address
  end

  it "must have a phone number" do
    customer = Customer.new(name: "Anna", address: "234 flower street", registered_at: "some time")
    customer.valid?.must_equal false
    customer.errors.messages.must_include :phone

  end

it "must have a registered_at " do
  customer = Customer.new(name: "Anna", address: "234 flower street", phone: "000-768-6252")
  customer.valid?.must_equal false
  customer.errors.messages.must_include :registered_at
end
end # END of describe "validations"

end
