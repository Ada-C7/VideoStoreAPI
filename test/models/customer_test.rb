require "test_helper"

describe Customer do
  let (:new_customer) { Customer.new(
    name: "Kelsey",
    registered_at: "11-27-2012",
    address: "1111 My Street",
    city: "Omaha",
    state: "NE",
    postal_code: "68116",
    phone: "555-555-5555",
    account_credit: 9.99
    )
  }

  REQUIRED_FIELDS = %w(name registered_at address city state postal_code phone account_credit)

  it "Can create a valid customer" do
    new_customer.must_be :valid?
  end

  it "Customer must have required fields" do
    REQUIRED_FIELDS.each do | field |
      proc {
        customers(:kelsey)[field] = nil
        Customer.new(customers(:kelsey))
      }
    end
  end

  # it "Customer is requred to have a name" do
  #
  # end
  #
  # it "Customer is requred to have a registered_at" do
  #
  # end
  #
  # it "Customer is required to have an address" do
  #
  # end
  #
  # it "Customer is required to have a city" do
  #
  # end
  #
  # it "Customer is required to have a state" do
  #
  # end
  #
  # it "Customer is required to have a postal_code" do
  #
  # end
  #
  # it "Customer is requried to have a phone" do
  #
  # end
  #
  # it "Customer is required to have account_credit" do
  #
  # end

end
