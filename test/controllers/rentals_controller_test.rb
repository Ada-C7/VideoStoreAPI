require "test_helper"

describe RentalsController do
  describe 'create' do

    before do
      @customer = customers(:good_customer)
      @movie = movies(:movie1)
    end

    let(:rental_data) { { customer_id: @customer.id } }

    it 'creates a new rental' do
      post rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :success
    end

  end
end
