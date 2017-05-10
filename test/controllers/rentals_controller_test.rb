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
    proc {
      post rental_path(movies(:one).title)
    }.must_change 'Rental.status', "checked out"

    must_respond_with :success
  end

  it "changes available inventory" do
    proc {
      post rental_path(movies(:one).title)
    }.must_change 'Rental.inventory', 0

    must_respond_with :success
  end

  it "sets a due date of 30 days after" do
    proc {
      post rental_path(movies(:one).title)
    }.must_change 'Rental.due_date', check_out_date + 30.days

    must_respond_with :success
  end

  it "gives error message if movie isn't available" do
    proc {
        post movies_path, params: {movie: { title: "Foo", available_inv: 0 }}
      }.wont_change "Movie.available_inv", 0

    body = JSON.parse(response.body)
    body.must_equal "errors" => {"name" => ["movie not available"]}
  end

  it "won't change the database if movie isn't available" do
    proc {
        post movies_path, params: {movie: { title: "Foo", available_inv: 0 }}
      }.wont_change "Movie.available_inv", 0

      must_respond_with :bad_request
  end
end


end
