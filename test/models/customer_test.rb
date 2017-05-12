require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "all customers in database are valid" do
    customers = Customer.all
    customers.each do |customer|
      customer.must_be_kind_of Customer
    end
  end

  # No validations exist.
  # it 'customer can not be created without required attributes' do
  #   proc { Customer.new }.must_raise ArgumentError
  # end
end
