require "test_helper"

describe RentalsController do

  describe 'create' do
    before do
      @bad_customer_id = Customer.all.last.id + 1
      @customer = customers(:good_customer)
      @movie = movies(:movie1)
    end

    let(:rental_data) { { customer_id: @customer.id } }

    it 'creates a new rental' do
      post create_rental_path(@movie.title), params: { rental: rental_data }
      must_respond_with :success
      response.parsed_body.must_include "id"
      Rental.find(response.parsed_body["id"]).movie_id.must_equal @movie.id
      Rental.find(response.parsed_body["id"]).customer_id.must_equal @customer.id
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
      # rental_data = {"customer_id"=>1}
      # post create_rental_path(movies(:one).title), params: {rental: rental_data }
      # patch update_rental_path(movies(:one).title), params: {rental: rental_data }
      get overdue_rentals_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array of hashes' do
      get overdue_rentals_path
      response.parsed_body.must_be_instance_of Array
      response.parsed_body.each do |overdue_rentals_hash|
        movie_hash.must_be_instance_of Hash
      end
    end

    it 'returns the correct amount of overdue rentals' do
      get overdue_rentals_path
      response.parsed_body.length.must_equal Rental.where(status: "overdue").count
    end

    it 'returns overdue rentals with the expected fields' do
      keys = %w( check_out_date customer_id due_date name postal_code title )
      get overdue_rentals_path
      response.parsed_body.each do |rental|
        rental.keys.sort.must_equal keys
      end
    end

    # it 'returns json message if there are no overdue movies' do
    #   Rental.destroy_all
    #   get overdue_rentals_path
    #   response.status.must_equal :no_content
    #   response.parsed_body.must_include "error"
    # end
  end

  describe "update" do
    before do
      customer = customers(:good_customer)
      @rental_data = { "customer_id": customer.id  }
      @movie = movies(:movie1)
      # create a rental for this customer and movie
      post create_rental_path(@movie.title), params: { rental: @rental_data }
      rental_id = response.parsed_body["id"]
      @rental = Rental.find_by(id: rental_id)

    end

    it "a working api route" do
      patch update_rental_path(@movie.title), params: { rental: @rental_data }
      must_respond_with :success
    end

    it 'returns json' do
      patch update_rental_path(@movie.title), params: { rental: @rental_data }
      response.header['Content-Type'].must_include 'json'
    end

    it "changes rental status" do
      puts "rental before"
      p @rental

      patch update_rental_path(@movie.title), params: { rental: @rental_data }
      # p response.parsed_body
      response.parsed_body.must_include "status"
      rental = @rental.reload
      # p Rental.all

      rental = Rental.find(rental.id)
      puts "rental after"
      p rental
      puts "print all"
      p Rental.all
      rental.status.must_equal "checked in"
    end
  end
end
