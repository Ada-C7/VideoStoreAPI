require 'test_helper'

describe CustomersController do
  describe 'index' do
    it 'gets customers route' do
      get customers_path
      must_respond_with :success
    end

    it 'returns json' do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an Array' do
      get customers_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it 'returns all of the customers' do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it 'returns customers with exactly the the required fields' do
      # this has to be in this specific order or it will not pass
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end
  describe 'overdue' do
    before do
      Rental.create(movie_id:3, customer_id:3, checkout_date:Time.now, due_date:Time.now+2.days)

      Rental.create(movie_id:1, customer_id:1, checkout_date:Time.now-3, due_date:Time.now+1)
    end
    it "gets overdue path" do
      get overdue_path
      must_respond_with :success
    end
    it "returns json" do
      get overdue_path
      response.header['Content-Type'].must_include 'json'
    end
    it "returns an array" do
      get overdue_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end
    it "returns all customers with overdue items" do
      get overdue_path
      body = JSON.parse(response.body)
      body.length.must_equal Rental.where("due_date <= ?", Time.now).length
    end

    it "returns required fields" do
      keys = %w(postal_code customer_id checkout_date due_date title name)
      get overdue_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
    it "returns 204 error if there are no customers with overdue items" do
      Rental.delete_all
      get overdue_path
      body = JSON.parse(response.body)
      body.must_be_empty

    end
  end
end
