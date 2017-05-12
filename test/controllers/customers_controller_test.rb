require "test_helper"

describe CustomersController do

  KEYS = %w(address city id movies_checked_out_count name phone postal_code registered_at state)

  describe "index" do
    it "is a real working route" do
      get customers_url
      must_respond_with :success
    end

    it "returns an array of json objects" do
      get customers_url
      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the cutsomers" do
      get customers_url
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns alphebetized list if params contain sort" do
      get customers_url, params: {sort: "name"}
      body = JSON.parse(response.body)

      all_customers = Customer.all
      sorted_list = all_customers.sort_by {|customer| customer.name}

      body.first["name"].must_equal sorted_list.first.name
    end

    it "returns required fields" do
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal KEYS
      end
    end
  end

  describe "show" do
    it "must get a customer" do
      get customer_url(customers(:one).id)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
      body.keys.sort.must_equal KEYS
    end

    it "responds correctly when customer not found" do
      get customer_url(Customer.last.id + 1)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body["errors"].must_include "customer"
    end

    it "when gets a customer has the right info" do
      get customer_path(customers(:one).id)
      body = JSON.parse(response.body)

      KEYS.each do |key|
        body[key].must_equal customers(:one)[key]
      end
    end
  end
end
