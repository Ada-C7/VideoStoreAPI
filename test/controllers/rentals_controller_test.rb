require "test_helper"

describe RentalsController do

  describe 'create' do
    before do
      @bad_customer_id = Customer.all.last.id + 1
      @customer = customers(:good_customer2)
      @movie = movies(:movie3)
    end

    let(:rental_data) { { customer_id: @customer.id } }

    it 'creates a new rental' do
      post create_rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :success
      response.parsed_body.must_include "rental_id"
      Rental.find(response.parsed_body["rental_id"]).movie_id.must_equal @movie.id
      Rental.find(response.parsed_body["rental_id"]).customer_id.must_equal @customer.id
    end

    it 'wont create a rental if customer already has that movie checked out' do
      post create_rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :success
      post create_rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :bad_request
      response.parsed_body.must_include "error"
    end

    it 'allows a customre to checkout out a movie again, if repeat rentals status is checked in' do
      post create_rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :success
      patch update_rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :success
      post create_rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :success
      # repeat_rentals = @customer.rentals.where(movie_id: @movie.id)
      # repeat_rentals.each {|rental| rental.}
    end

    it 'returns bad request if given customer id DNE' do
      post create_rental_path(@movie.title), params: { rental: { customer_id: @bad_customer_id } }
      must_respond_with :bad_request
      response.parsed_body.must_include "errors"
    end

    it 'returns bad request if given movie title DNE' do
      post create_rental_path("Harry Potter"), params: { rental: rental_data }
      must_respond_with :bad_request
      response.parsed_body.must_include "errors"
    end
  end

  describe "overdue_rentals" do

    it 'is a real working api route' do
      get overdue_rentals_path
      must_respond_with :success
    end

    it 'returns json' do
      get overdue_rentals_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array of hashes' do
      # skip
      get overdue_rentals_path
      response.parsed_body.must_be_instance_of Array
      response.parsed_body.each do |overdue_rentals_hash|
        overdue_rentals_hash.must_be_instance_of Hash
      end
    end

    it 'returns the correct amount of overdue rentals' do
      get overdue_rentals_path
      overdue_rentals = Rental.where(status: "overdue")
      response.parsed_body.length.must_equal overdue_rentals.length
    end

    it 'returns overdue rentals with the expected fields' do
      keys = %w( check_out_date customer_id due_date name postal_code title )
      get overdue_rentals_path
      response.parsed_body.each do |rental|
        rental.keys.sort.must_equal keys
      end
    end

    it 'returns json message if there are no overdue movies' do
      Rental.destroy_all
      get overdue_rentals_path
      # learning note: status will return the HTTP status code
      # response.status.must_equal 200
      # learning note: must_respond_with lets you test to the HTTP  status message
      must_respond_with :success
      response.parsed_body.must_include "message"
    end
  end
end
