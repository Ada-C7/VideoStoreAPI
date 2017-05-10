require "test_helper"


describe CustomersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  CUSTOMER_KEYS = %w(id name phone postal_code registered_at)


  describe "index" do
    it "is a working route" do
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

    it "returns all the customers" do
      get customers_url

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns the correct fields" do


      get customers_url

      body = JSON.parse(response.body)

      body.each do |customer|

        customer.keys.sort.must_equal CUSTOMER_KEYS
      end
    end
  end

  describe "show" do
    it "gets the show route" do
      get customer_url(customers(:mary).id)

      must_respond_with :success
    end

    it "returns json" do
      get customer_url(customers(:mary).id)

      response.header['Content-Type'].must_include 'json'
    end

    it "returns a hash" do
      get customer_url(customers(:mary).id)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns the correct fields" do
      get customer_url(customers(:mary).id)

      body = JSON.parse(response.body)

      CUSTOMER_KEYS.each do |key|
        body[key].must_equal customers(:mary)[key]
      end
    end

    it "returns empty hash and bad_request status if no customer can be found" do
      get customer_url(Customer.all.last.id + 1)

      body = JSON.parse(response.body)
      # empty_hash = {}
      body.must_be_kind_of Hash
      body.must_be_empty
      # body.must_equal empty_hash

      must_respond_with :not_found
    end

  end

end
