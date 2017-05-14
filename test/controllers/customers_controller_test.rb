require "test_helper"

describe CustomersController do
  it "gets an index" do
    get customers_path
    must_respond_with :success
  end
end
