require "test_helper"

describe "CustomersController" do
CUSTOMER_KEYS = %w(id movies_checked_out_count name phone postal_code registered_at)

  describe "index" do
    before do
      get customers_url
    end

    it "is an actual route" do
      must_respond_with :success
    end

    it "returns json" do
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array of all the customers" do
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal CUSTOMER_KEYS
      end
    end
  end

  describe "index with sort parameter" do
    it "sorts customers by name" do
        get customers_path(sort: name)
        # check first and last against sorted db
        body = JSON.parse(response.body)
        body.each do |customer|

    end

    it "sorts customers by date registered" do skip

    end

    it "sorts customers by postal code" do skip

    end

    it "reverts to rails default if sort value is not valid" do skip

    end
  end
end
