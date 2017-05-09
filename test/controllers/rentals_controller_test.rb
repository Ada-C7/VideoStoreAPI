require "test_helper"

describe RentalsController do
  describe "Checkout" do
    let(:rental) {
      {
        movie: movies(:one).title,
        customer: customers(:one)
      }
    }

  it "creates a new rental" do
    proc {
      post rental_path(movies(:one).title)
    }.must_change 'Rental.count', 1

    must_respond_with :success
  end

  it "changes status code for rental" do
    skip
  end

  it "changes available inventory" do
    skip
  end

  it "sets a due date of 30 days after" do
    skip
  end

  it "gives error message if movie isn't available" do
    skip
  end
end


end
