require "test_helper"

describe Customer do
  describe "Validation" do
    before do
      @input = { name: "Shelley Rocha",
        registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
        address: "Ap #292-5216 Ipsum Rd.",
        city: "Hillsboro",
        state: "OR",
        postal_code: "24309",
        phone: "(322) 510-8695",
      }
    end
    it "Can be created with all attributes" do
      customer = Customer.new(@input)
      result = customer.valid?
      result.must_equal true
    end
    it "Cannot be created without attributes" do
      customer = Customer.new
      result = customer.valid?
      result.must_equal false
    end
    it "cannot be created with invalid city" do
      @input[:city] = "CityWithNumbers12345"
      customer = Customer.new(@input)
      result = customer.valid?
      result.must_equal false
    end
    it "cannot be created with invalid state" do
      @input[:state] = "StateWithNumbers12345"
      customer = Customer.new(@input)
      result = customer.valid?
      result.must_equal false
    end
    it "cannot be created if postal_code length != 5" do
      @input[:postal_code] = 3232903
      customer = Customer.new(@input)
      result = customer.valid?
      result.must_equal false
    end
    it "cannot be created if postal_code is not contains all digits" do
      @input[:postal_code] = "123la"
      customer = Customer.new(@input)
      result = customer.valid?
      result.must_equal false
    end
    it "cannot be created if phone is not valid" do
      @input[:phone] = "2332323232232"
      customer = Customer.new(@input)
      result = customer.valid?
      result.must_equal false
    end
    it "Cannot be created even if one attributes is not presented" do
      @input.keys.each do |key|
        @input.delete(key)
        customer = Customer.new(@input)
        result = customer.valid?
        result.must_equal false
      end

    end
  end






end
