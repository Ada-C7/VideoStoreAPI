require "test_helper"

describe CustomersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    it "is a working route" do
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

    it "returns all the customers" do
      get customers_url

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns the correct fields" do
      KEYS = %w(id name phone postal_code registered_at)

      get customers_url

      body = JSON.parse(response.body)

      body.each do |customer|
        customer.keys.sort.must_equal KEYS
      end


    end

  end

end
