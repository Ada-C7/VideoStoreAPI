require "test_helper"

describe Customer do

  let(:customer) { Customer.new }

  it "all customers must be valid" do
    customers.each do |customer|
      value(customer).must_be :valid?
    end
  end

  it "does not save an invalid customer" do
    customer.wont_be :valid?
  end

  describe "validation tests" do
    it "Name must be present" do
      customer[:name] = nil
      customer.must_be :invalid?
    end

    it "Phone must be present" do
      customer[:phone] = nil
      customer.must_be :invalid?
    end


    it "registered at must be present" do
      customer[:registered_at] = nil
      customer.must_be :invalid?
    end

    it "State must be present" do
      customer[:state] = nil
      customer.must_be :invalid?
    end

    it "movies checked out count must be present" do
      customer[:movies_checked_out_count] = nil
      customer.must_be :invalid?
    end

    it "is invalid without a name" do
      customer = Customer.new
      result = customer.valid?
      result.must_equal false
    end
  end
end
