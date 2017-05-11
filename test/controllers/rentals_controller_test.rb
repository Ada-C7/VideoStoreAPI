require "test_helper"

describe RentalsController do
  describe "overdue_rentals" do
    before do
      @customer_id = customers(:good_customer).id
      @rental = {
                        movie_id: movies(:one).id,
                        customer_id: @customer_id,
                        check_out_date: Date.today,
                        due_date: Date.today + 3,
                        status: "checked out"
                     }


    end
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
      keys = %w( check_out_date, customer_id, due_date,  name, postal_code , title)
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
    # it "updates existing rental" do
    #   rental_data = {"customer_id"=>1}
    #   patch update_rental_path(movies(:one).title), params: {rental: rental_data }
    # end
    it "changes rental status" do

    end
    it " " do

    end




  end





end
