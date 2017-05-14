require "test_helper"

describe CustomersController do
  it "gets an index" do
    get customers_path
    must_respond_with :success
  end

  it "the response must be of type json" do
    get customers_path
    response.header['Content-Type'].must_include "json"
  end

  it "returns the correct amount of customers" do
    get customers_path
    r = JSON.parse(response.body)
    r.length.must_equal Customer.count
  end
end
