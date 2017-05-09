require "test_helper"

describe CustomersController do
  describe "index" do
    it "can return a list of customers in JSON" do
      get customers_path
      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
    end

    it "returns all of the customers" do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "will return a 404 if there are no customers" do
      Customer.destroy_all
      get customers_path
      must_respond_with :not_found
    end
  end
end
