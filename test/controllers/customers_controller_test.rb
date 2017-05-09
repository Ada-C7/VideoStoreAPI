require "test_helper"

describe CustomersController do
  describe "index" do
    it "routes successfully" do
      get customers_url

      must_respond_with :success
    end

    it "returns json" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end
  end
end
