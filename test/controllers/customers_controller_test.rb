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
  end
end
