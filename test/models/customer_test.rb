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

    it "is invalid without a phone number" do
      customer = customers(:tamiko)
      customer.valid?.must_equal false
    end

  end
end
