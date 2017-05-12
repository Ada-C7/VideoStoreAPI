require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  # 
  # it "must be valid" do
  #   value(customer).must_be :valid?
  # end
  describe "validations" do
    it "must create a new customer with good info" do
      customer.account_credit = 12.00
      customer.address = "123 Bob Lives Here"
      customer.city = "Seattle"
      customer.name = "Bob Smart"
      customer.phone = "(123) 456-7890"
      customer.postal_code = "12345"
      customer.registered_at = "Wed, 20 Apr 2016 07:54:14 -0700"
      customer.state = "KS"
      customer.save!
      customer.valid?.must_equal true
    end

    it "is invalid without a name" do
      customer.account_credit = 2.00
      customer.address = "456 Grr Lane"
      customer.city = "Seattle"
      # customer.name =
      customer.phone = "(123) 456-7890"
      customer.postal_code = "12345"
      customer.registered_at = "Fri, 15 Apr 2016 07:54:14 -0700"
      customer.state = "KS"
      # customer.save! can't have this idk why
      customer.valid?.must_equal false
    end
  end
end
