require "test_helper"

describe Customer do
  REQUIRED_FIELDS = %w(name registered_at address city state postal_code phone account_credit)

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

      it " Account_credit must be a number" do
        new_customer.account_credit = "number"
        new_customer.valid?.must_equal false
      end

    end

    describe " Custom Methods" do

      it " Returns number of movies checked out by customer instance" do
        customers(:one).movies_checked_out_count.must_equal 2
      end

      it " Returns 0 if customer has not checked out any movies" do
        customers(:three).movies_checked_out_count.must_equal 0
      end

      it " Retuns correct number when customer has checked in rentals " do
        customers(:two).movies_checked_out_count.must_equal 1
      end

    end
  end
