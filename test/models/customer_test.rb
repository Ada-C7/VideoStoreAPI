require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "all customers must be valid" do
    :one.must_be :valid?
  end
end

# describe "validation tests" do
#   it "Customer must be present" do
#     customer[:one] = nil
#     customer.save
#     customer.must_be :invalid?
#   end
# end
