require "test_helper"

describe Customer do

  # hash = {
  #   name: "Freddie Mac",
  #   registered_at: "Sat, 29 Apr 2013 07:74:14 -0700",
  #   address: "292-5216 Ipsum Rd",
  #   city: "Waterloo",
  #   state: "OR",
  #   postal_code: "string",
  #   phone: "4252409511",
  #   account_credit: 54.64,
  #   movies_checked_out_count: 0
  # }

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
    # required test (1/4)
    it "Name must be present" do
      customer[:name] = nil
      customer.save
      customer.must_be :invalid?
    end

    it "Phone must be present" do
      customer[:phone] = nil
      customer.must_be :invalid? #assert user.invalid?
    end


    it "is invalid without a name" do
      customer = Customer.new
      result = customer.valid?
      result.must_equal false
    end
  end


  # describe "association test" do
  #   it "movies" do
  #     assert_equal 2, customers(:fannie).movies.size
  #   end
  # end


end
