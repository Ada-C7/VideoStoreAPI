require "test_helper"

describe CustomersController do

  describe "index" do

    it "responds with no customers" do
      # skip
      Customer.destroy_all

      get customers_path
      must_respond_with :success
    end

    # TODO must create fixtures with many users
    it "responds with multiple customers" do
      # skip
      Customer.count.must_be :>, 0

      get customers_path
      must_respond_with :success
    end
  end



  end

  describe "show" do
    it "responds with an existing customer" do
      # skip
      get customer_path(Customer.first)
      must_respond_with :success
    end

    it "204 with invalid user data" do
      # skip
      bad_customer_id = Customer.last.id + 1
      get customer_path(bad_customer_id)
      must_respond_with :no_content
    end
end

end
