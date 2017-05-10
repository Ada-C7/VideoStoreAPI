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
      response.parsed_body.must_include "id"
      Rental.find(response.parsed_body["id"]).movie_id.must_equal @movie.id
      Rental.find(response.parsed_body["id"]).customer_id.must_equal @customer.id
    end


  end
end
