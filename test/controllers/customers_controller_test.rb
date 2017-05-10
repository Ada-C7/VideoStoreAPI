require "test_helper"

describe CustomersController do

  describe "index" do

    it "is a real working route" do
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

    it "returns all of the customers" do
      get customers_url
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(name resistered_at postal_code phone movies_checked_out)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end
end

    # T_T: this belongs in Movies Controller (after we make one)
    #
    # describe 'Movies#all' do
    #   it "must return a collection of Movies" do
    #   end
    #
    #   it "returns empty Array when no movies exist" do
    #   end
    # end
    #
    # describe 'Movies#create' do
    #   it "adds a movie to our active record" do
    #   end
    # end
    #
    # describe 'Movies#find' do
    #   it "finds one Movie with a valid title" do
    #   end
    #
    #   it "find an empty array with a nonexistant title" do
    #   end
    # end
