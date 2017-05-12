require "test_helper"

describe CustomersController do
  describe "index" do
    it "is successful renders when there are many customers" do
      Customer.count.must_be :>, 0
      get customers_path
      must_respond_with :success
    end

    it "is successful when there are zero customers" do
      Customer.destroy_all
      get customers_path
      must_respond_with :success
    end

    it "returns JSON" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array of customers" do
      get customers_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_url
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with the right fields" do
      fields = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal fields
      end
    end
  end
end
