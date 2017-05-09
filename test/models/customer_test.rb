require "test_helper"

describe Customer do
  let(:customer) { customers(:alison, :brenna).sample }

  it "must have a name" do
    customer.name.must_equal customer.name
  end

  it "is invalid without a name" do

  end

  it "must have a phone number" do
    customer.phone.must_equal customer.phone
  end

  it "is invalid without a phone number" do

  end

  it "must have a registered_at date" do
    customer.registered_at.must_equal customer.registered_at
  end

  it "is invalid without a register date" do

  end

  it "can have address, city, state, postal_code, account_credit" do
    customer.address.must_equal customer.address
    customer.city.must_equal customer.city
    customer.state.must_equal customer.state
    customer.postal_code.must_equal customer.postal_code
    customer.account_credit.must_equal customer.account_credit
  end

  # it "returns an array of movie rentals" do
  #
  # end
  #
  # it "can have multiple movie rentals" do
  #
  # end


end
