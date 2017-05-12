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
    account_credit: 9.99,
    movies_checked_out: 12
    )
  }

  it "Can create a valid customer" do
    new_customer.must_be :valid?
  end

  REQUIRED_FIELDS = %w(name registered_at address city state postal_code phone account_credit)

  REQUIRED_FIELDS.each do | field |
    it "Customer must have a #{field}" do
      new_customer[field] = nil
      new_customer.valid?.must_equal false
      new_customer.errors.messages.must_include field.to_sym
    end
  end

  NUMERICALITY_FIELDS = %w(account_credit movies_checked_out)

  NUMERICALITY_FIELDS.each do | field |
    it "Customer #{field} must be a number" do
      new_customer[field] = "zero"
      new_customer.valid?.must_equal false
      new_customer.errors.messages.must_include field.to_sym
    end
  end
end
