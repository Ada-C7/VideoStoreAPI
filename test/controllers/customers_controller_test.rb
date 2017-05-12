require "test_helper"

describe CustomersController do
  describe "index" do
    it "responds with no customers" do
      Customer.destroy_all
      get customers_path
      body = JSON.parse(response.body)
      body["message"].must_be_kind_of String
      must_respond_with :success
    end

    it "responds with multiple customers" do
      Customer.count.must_be :>, 0
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with an existing customer" do
      c = Customer.first
      get customer_path(c)
      body = JSON.parse(response.body)
      body["id"].must_equal c.id
      must_respond_with :success
    end

    it "404 with invalid user data" do
      bad_customer_id = Customer.last.id + 1
      get customer_path(bad_customer_id)
      must_respond_with :not_found
    end
  end
end
