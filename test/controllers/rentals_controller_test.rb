require "test_helper"

describe RentalsController do
  describe "check_out" do
    let(:rental_data) {
      {
        customer_id: customers(:aj).id,
        due_date: "2017-05-22"
      }
    }

    it "creates a new rental" do
      proc {
        post check_out_url(movies(:star_wars).title), params: rental_data
      }.must_change 'Rental.count', 1
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      new_rental = Rental.find(body["id"])
      new_rental.due_date.must_equal rental_data[:due_date]
      new_rental.is_current.must_equal true
    end

    it "does not create a new rental if data is missing" do
      rental_data.delete(:customer_id)
      proc {
        post check_out_url(movies(:star_wars).title), params: rental_data
      }.wont_change 'Rental.count'
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body["errors"].must_include "customer"
    end
  end

  describe "check_in" do
    let(:rental_data) {
      {
        customer_id: customers(:aj).id
      }
    }

    it "checks in a rental" do
      post check_in_url(movies(:star_wars).title), params: rental_data
      must_respond_with :success

      customers(:aj).movies_checked_out_count.must_equal 0

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      rental = Rental.find(body["id"])
      rental.movie.title.must_equal movies(:star_wars).title
      rental.is_current.must_equal false
    end

    it "does not check in a rental if data is missing" do
      rental_data.delete(:customer_id)
      post check_in_url(movies(:star_wars).title), params: rental_data
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body["errors"].must_include "Rental not found"
    end
  end

end
