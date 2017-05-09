require "test_helper"

describe CustomersController do
  KEYS = %w(id name registered_at postal_code phone movies_checked_out_count)

  describe "index" do
    it "routes successfully" do
      get customers_url
      must_respond_with :success
    end

    it "returns json" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns the appropriate fields" do
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal KEYS.sort
      end
    end
  end
end
