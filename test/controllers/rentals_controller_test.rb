require "test_helper"

describe RentalsController do
  describe "create" do
    let(:rental_data) {
      {
        title: movies(:one).title,
        customer_id: customers(:one).id,
        due_date: "2017-06-30"
      }
    }

    it "Creates a new rental" do
      proc {
        post check_out_path, params: { rental: rental_data }
      }.must_change 'Rental.count', 1
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      # Check that the ID matches
      Rental.find(body["id"]).movie.title.must_equal rental_data[:title]
      Rental.find(body["id"]).customer_id.must_equal rental_data[:customer_id]
      Rental.find(body["id"]).due_date.must_equal Date.parse(rental_data[:due_date])
    end

    # may need more tests for cases: missing customer, missing duedate
    it "Returns an error for an invalid rental" do
      bad_data = rental_data.clone()
      bad_data.delete(:title)

      proc {
        post check_out_path, params: { rental: bad_data }
      }.wont_change 'Rental.count'
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "movie"
      body.must_equal "errors" => {"movie" => ["can't be blank"]}
    end
  end

  it "should get update" do
    get rentals_update_url
    value(response).must_be :success?
  end

  it "should get overdue" do
    get rentals_overdue_url
    value(response).must_be :success?
  end

end
