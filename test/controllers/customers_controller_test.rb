require "test_helper"

describe CustomersController do
  KEYS = %w(movies_checked_out_count name phone postal_code registered_at)

  describe "index" do
    it "gets list of customers" do
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal KEYS
      end
    end

    it "returns an empty array if no customers" do
      Customer.delete_all
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_equal []
    end
  end
end
