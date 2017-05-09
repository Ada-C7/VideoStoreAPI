require "test_helper"

describe Customer do
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

  # it "won't create customer without registered_at" do
  #
  # end
  #
  # it "won't create customer without postal_code" do
  #
  # end
  #
  # it "won't create customer without phone" do
  #
  # end
  #
  # it "won't create customer without movies_checked_out_count" do
  #
  # end
  #
  # it "creates customer without address" do
  #
  # end
  #
  # it "creates customer without city" do
  #
  # end
  #
  # it "creates customer without state" do
  #
  # end
end
