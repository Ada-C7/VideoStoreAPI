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
end
