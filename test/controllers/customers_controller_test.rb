require "test_helper"

describe CustomersController do
  describe 'index' do
    it 'the route works' do
      get customers_url
      must_respond_with :success
    end

    it 'returns json' do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array' do
      get customers_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it 'returns all customers' do
      get customers_url

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it 'returns customers with all required fields' do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_url


      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it 'renders no content if customers do not exist' do
      Customer.destroy_all

      get customers_url
      puts "#{Customer.class}"
      assert_response :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body["error"].must_include "List not found"
      body["status"].must_equal 404
    end
  end
end
