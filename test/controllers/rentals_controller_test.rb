require "test_helper"

describe RentalsController do
    let(:info) {
      {
        "customer_id" => customers(:sam).id,
        "due_date" => "2018-01-23"
      }
    }

  it "Can create a new rental" do
    proc {
    post new_rental_path(movies(:starwars).title), params: { rental: info }
    }.must_change 'Rental.count', 1
    must_respond_with :success
  end

  it "responds with an error if inventory goes over" do
    post new_rental_path(movies(:jaws).title), params: { rental: info }
    must_respond_with :success
    post new_rental_path(movies(:jaws).title), params: { rental: info }
    must_respond_with :bad_request
    r = JSON.parse(response.body)
    r.must_include "error"
  end

  it "does not create a rental with a bad request" do
    bad_info = {
        "due_date" => "2018-01-23"
    }
    
    post new_rental_path(movies(:jaws).title), params: { rental: bad_info }
    must_respond_with :bad_request
  end
end
