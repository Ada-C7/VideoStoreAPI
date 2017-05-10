require "test_helper"

describe RentalsController do
  describe "Checkout" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id
      }
    }

  it "creates a new rental" do
    proc {
      post checkout_path(movies(:one).title), params: {rental: rental_data}
    }.must_change 'Rental.count', 1

    must_respond_with :success
  end

  it "changes status for rental" do
    post checkout_path(movies(:one).title), params: {rental: rental_data}

    rental = Rental.last
    rental.status.must_equal "checked out"

    must_respond_with :success
  end

  it "changes available inventory" do
    post checkout_path(movies(:one).title), params: {rental: rental_data}

    movie = Movie.last
    movie.available_inv.must_equal 99

    must_respond_with :success
  end

  it "sets a due date of 30 days after" do

    post checkout_path(movies(:one).title), params: {rental: rental_data}

    rental = Rental.last
    rental.due_date.must_equal "#{Time.now + 30.days}"

    must_respond_with :success

  end

  it "gives error message if movie isn't available" do

    post checkout_path(movies(:two).title), params: {rental: rental_data}

    body = JSON.parse(response.body)
    body.must_equal  "message" => "movie not available"

    must_respond_with :not_acceptable

  end

  it "won't change the database if movie isn't available" do

    post checkout_path(movies(:one).title), params: {rental: rental_data}

    movie = Movie.last
    movie.available_inv.must_equal 99

    must_respond_with :success

  end
end

describe "overdue" do
  # let(:rental_data) {
  #   {
  #     customer_id: customers(:one).id
  #   }
  # }

  it "changes the status of a rental if the due date has passed" do
    # post checkout_path(movies(:one).title), params: {rental: rental_data}

    rental = Rental.last
    rental.status.must_equal "overdue"
    

    must_respond_with :success
  end

end

end
