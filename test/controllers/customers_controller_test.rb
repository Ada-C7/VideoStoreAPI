require "test_helper"

describe CustomersController do
  describe "index" do
    it "can return a list of customers in JSON" do
      get customers_path
      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
    end

    it "returns all of the customers" do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "will return a 404 if there are no customers" do
      Customer.destroy_all
      get customers_path
      must_respond_with :not_found
    end
  end

  describe "sort method in index" do
    it "can sort by name" do
      get '/customers?sort=name'
      must_respond_with :success
      body = JSON.parse(response.body)
      body[0]["name"].must_equal "Curran Stout"
    end

    it "can sort by registered date" do
      get '/customers?sort=registered_at'
      must_respond_with :success
      body = JSON.parse(response.body)
      body[0]["registered_at"].must_equal "2014-04-16T21:40:20.000Z"
    end

    it "can sort by postal code" do
      get '/customers?sort=postal_code'
      must_respond_with :success
      body = JSON.parse(response.body)
      body[0]["name"].must_equal "Shelley Rocha"
    end

    it "returns just a regular list of people for a sort request that isn't allowed" do
      get '/customers?sort=potatoes'
      must_respond_with :success
      body = JSON.parse(response.body)
      body[0]["name"].must_equal "Shelley Rocha"
    end

  end
end
