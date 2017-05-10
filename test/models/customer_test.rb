require "test_helper"

describe Customer do

  describe "relationships" do

    it "has many rentals" do
      ar = Customer.reflect_on_association(:rentals)
      expect(ar.macro) == :has_many
    end

  end

  describe "validations" do

    it "is invalid without a name" do
      customer = customers(:sahana)
      customer.valid?.must_equal false
    end

    it "is valid with a name" do
      customer = customers(:sahana1)
      customer.valid?.must_equal true
    end

    it "is invalid without a phone number" do
      customer = customers(:tamiko)
      customer.valid?.must_equal false
    end

    it "is valid with a phone number" do
      customer = customers(:tamiko1)
      customer.valid?.must_equal true
    end

    it "is invalid without a registered_at date" do
      customer = customers(:bahana)
      customer.valid?.must_equal false
    end

    it "is valid with a registered_at date" do
      customer = customers(:perfect)
      customer.valid?.must_equal true
    end

    it "is valid without a postal code" do
      customer = customers(:no_postal)
      customer.valid?.must_equal true
    end

    it "is valid with a 5 character postal code" do
      customer = customers(:perfect)
      customer.valid?.must_equal true
    end

    it "is invalid without a 5 character postal code" do
      customer = customers(:four)
      customer.valid?.must_equal false

      customer_one = customers(:six)
      customer_one.valid?.must_equal false
    end

    it "is invalid without an account_credit" do
      customer = customers(:no_credit)
      customer.valid?.must_equal false
    end

    # Tried to test and invalidate strings, but found out strings will automatically get converted to a zero value
    # it "is invalid with a non-numerical account_credit" do
    #   customer = customers(:string_credit)
    #   binding.pry
    #   customer.valid?.must_equal false
    # end

    it "is invalid with a negative account_credit" do
      customer = customers(:negative_credit)
      customer.valid?.must_equal false
    end

    it "is valid with a 0 account_credit value" do
      customer = customers(:zero_credit)
      customer.valid?.must_equal true
    end
  end
end
