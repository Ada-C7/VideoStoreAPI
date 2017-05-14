require "test_helper"

describe CustomersController do

  describe "index" do
    it "is a working route" do
      get customers_url
      must_respond_with :success
    end

    it "returns json" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
      response.header['Content-Type'].must_include 'application/json'
    end

    it "returns an array" do
      get customers_url
      # response.body.must_be_kind_of Array  # response.body is a string
      body = JSON.parse(response.body) # puts body gives the data in yml
      body.must_be_kind_of Array
    end

    it "returns an empty array if the model is empty" do
      Rental.destroy_all
      Customer.destroy_all
      get customers_url
      # response.body.must_be_kind_of Array  # response.body is a string
      body = JSON.parse(response.body) # puts body gives the data in yml
      body.must_be_kind_of Array
      body.must_be_empty
      body.must_equal []
    end

    it "returns all customers" do
      get customers_url
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end



  end # END of describe "index"

  describe "output for a customer" do
    it "returns value for id" do
      get customers_url
      body = JSON.parse(response.body)
      body[0].must_include "id"
    end

    it "returns value for name" do
      get customers_url
      body = JSON.parse(response.body)
      body[0].must_include "name"
    end

    it "returns value for registered_at" do
      get customers_url
      body = JSON.parse(response.body)
      body[0].must_include "registered_at"
    end

    it "returns value for postal_code" do
      get customers_url
      body = JSON.parse(response.body)
      body[0].must_include "postal_code"
    end

    it "returns value for phone" do
      get customers_url
      body = JSON.parse(response.body)
      body[0].must_include "phone"
    end

    it "returns value for movies_checked_out_count (from customer_serializer)" do
      get customers_url
      body = JSON.parse(response.body)
      body[0].must_include "movies_checked_out_count"
    end

    it "will not return value for city" do
      get customers_url
      body = JSON.parse(response.body)
      body[0].wont_include "city"
    end

  end # END of describe "output from customer_serializer"



end # END of describe CustomersController
