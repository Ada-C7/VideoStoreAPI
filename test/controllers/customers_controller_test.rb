require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
      get customers_url
      must_respond_with :success
    end

    it "returns json" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get customers_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      keys = %w(account_credit address city id name phone postal_code registered_at state)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    # describe "show" do
    #   it "can get a customer" do
    #     get customer_path(customers(:two).id)
    #     must_respond_with :success
    #   end
    #
    #   it "does not get a customer that does not exist" do
    #     get customer_path(Customer.last.id+1)
    #     must_respond_with :not_found
    #   end
    # end
  end
end
