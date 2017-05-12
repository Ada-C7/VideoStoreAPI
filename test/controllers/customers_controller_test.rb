require "test_helper"

describe CustomersController do

  describe "Customers#Index" do

    # need to add movies_checked_out_count
    FIELDS = %w(id movies_checked_out_count name phone postal_code registered_at)

    before do
      get customers_path
    end

    it "should get index" do
      must_respond_with :success
    end

    it "returns json" do
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns the correct fields" do
      body = JSON.parse(response.body)
      body.each do | customer |
        customer.keys.sort.must_equal FIELDS
      end
    end
  end
end
