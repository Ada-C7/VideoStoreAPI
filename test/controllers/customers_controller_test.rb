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
      get customers_url
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = ["account_credit", "address", "city", "id", "movies_checked_out_count", "name", "phone", "postal_code", "registered_at", "state"]
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it "returns empty array when there are no customers" do
      Customer.destroy_all
      get customers_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be_empty
    end
  end
end
