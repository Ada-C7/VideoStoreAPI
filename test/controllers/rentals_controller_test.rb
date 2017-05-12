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
      #
      # movie = Movie.last
      # movie.available_inv = 0
      # movie.save

      body = JSON.parse(response.body)
      body["errors"].must_include "movie"

    post checkout_path(movies(:two).title), params: {rental: rental_data}

      must_respond_with :not_acceptable


    end

    it "won't change the database if movie isn't available" do

      post checkout_path(movies(:one).title), params: {rental: rental_data}

      movie = Movie.last
      movie.available_inv.must_equal 99

      must_respond_with :success

    end
  end

  describe "Checkin" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
      }
    }

    it "should successfully check in the rental" do
      post checkin_path(movies(:one).title), params: {rental: rental_data}

      must_respond_with :success
    end

    it "should update the available inventory for that movie" do
      checkedout = movies(:one)
      title = checkedout.title

      post checkin_path(title), params: {rental: rental_data}

      updated = Movie.find_by_title(title)
      updated.available_inv.must_equal (checkedout.available_inv + 1)
    end

    it "should update the status of that rental" do
      post checkin_path(movies(:one).title), params: {rental: rental_data}

      #gets last updated rental from test db?
      updated_rental = Rental.last

      updated_rental.status.must_equal "Returned"
    end

    it "if Movie not found, return appropriate error & message" do
      post checkin_path("Bad Title"), params: {rental: rental_data}

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body["errors"].must_include "movie"
    end

    it "if Rental not found, return error and should not update database" do
      #there is no rental fixture with movie two.
      movie = movies(:two)
      title = movie.title

      post checkin_path(title), params: {rental: rental_data}

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body["errors"].must_include "rental"

      not_updated = Movie.find_by_title(title)
      not_updated.available_inv.must_equal movies(:two).available_inv
    end
  end

  describe "overdue" do
    # let(:rental_data) {
    #   {
    #     customer_id: customers(:one).id
    #   }
    # }

    # it "changes the status of a rental if the due date has passed" do
    #   # post checkout_path(movies(:one).title), params: {rental: rental_data}
    #
    #   rental = Rental.last
    #   rental.status.must_equal "overdue"
    #
    #
    #   must_respond_with :success
    # end

  end

end
