require "test_helper"

describe CustomersController do
  KEYS = %w(id name phone postal_code registered_at)

  describe "index" do
    it "is a real working route" do
      get customers_url
      must_respond_with :success
    end

    it "returns an array of json objects" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get customers_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_url

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with the required fields" do
      get customers_url
      body = JSON.parse(response.body)
        body.each do |customer|
          customer.keys.sort.must_equal KEYS
        end
    end

    it "returns an understandable error message if customers were not found" do
      customers= Customer.destroy_all
      get customers_url
      body = JSON.parse(response.body)
      body.must_equal "no_customers" => "Customers were not found"
      Customer.count.must_equal 0
      must_respond_with :not_found
    end
  end
end
