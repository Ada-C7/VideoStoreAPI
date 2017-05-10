require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get customers_show_url
    value(response).must_be :success?
  end

end
