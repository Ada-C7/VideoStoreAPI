require "test_helper"

describe Customer do
  REQUIRED_FIELDS = %w(name registered_at address city state postal_code phone account_credit movies_checked_out_count)

  let(:new_customer) { Customer.new(
    name: "Orange",
    registered_at: "2015-05-09",
    address: "123 Cool Street",
    city: "Portland",
    state: "OR",
    postal_code: "22222",
    phone: "555-555-5556",
    account_credit: 1.23
  ) }

  describe "Validations" do
    it "can create a customer" do
      new_customer.must_be :valid?
      new_customer.save.must_equal true
    end

    REQUIRED_FIELDS.each do |field|
      it "#{field} is required" do
        new_customer[field] = nil
        new_customer.valid?.must_equal false
        new_customer.errors.messages.must_include field.to_sym
      end
    end

    it "account_credit must be a number" do
      new_customer.account_credit = "number"
      new_customer.valid?.must_equal false
    end

    it "movies_checked_out_count must be a non-negative integer" do
      new_customer.movies_checked_out_count = "number"
      new_customer.valid?.must_equal false

      new_customer.movies_checked_out_count = 3.4
      new_customer.valid?.must_equal false

      new_customer.movies_checked_out_count = -5
      new_customer.valid?.must_equal false
    end

    it "movies_checked_out_count defaults to 0" do
      new_customer.save
      new_customer.movies_checked_out_count.must_equal 0
    end
  end
end
