require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "requires a name and phone number to create" do
    customer.valid?.must_equal false
    customer.errors.messages.must_include :name
  end

  it "can be created w/ name and phone" do
    customer.name = "Ben"
    customer.phone = "206-365-8186"

    customer.save.must_equal true
  end

  it "phone number must be unique" do
    customer.name = 'Name'
    customer.phone = "206-123-4567"
    customer.save.must_equal false
    customer.errors.messages.must_include :phone
  end

  it "can have many movies associated with it" do
    danielle = customers(:one)
    danielle.movies = [movies(:one)]
    danielle.save.must_equal true
  end
end
