require "test_helper"

describe RentalsController do
  describe "Checkout" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id
      }
    }

    let(:bad_rental_data) {
      {
        customer_id: (Customer.last.id + 1)
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
      movie = movies(:one)
      title = movie.title

      post checkout_path(title), params: {rental: rental_data}

      updated = Movie.find_by_title(title)
      updated.available_inv.must_equal (movie.available_inv - 1)
    end

    it "sets a due date of 30 days after" do

      post checkout_path(movies(:one).title), params: {rental: rental_data}

      rental = Rental.last
      rental.due_date.must_equal "#{Date.today + 30.days}"

      must_respond_with :success

    end

    it "updates movies_checked_out_count for that customer" do
      id = customers(:one).id

      checked_out = customers(:one).movies_checked_out_count
      post checkout_path(movies(:one).title), params: {rental: rental_data}

      customer = Customer.find_by_id(id)
      customer.movies_checked_out_count.must_equal (checked_out + 1)
    end

    it "gives error message if movie isn't available" do

      post checkout_path(movies(:two).title), params: {rental: rental_data}

      body = JSON.parse(response.body)
      body["errors"].must_equal "movie"=>["The Movie Psycho is not available"]

      must_respond_with :not_acceptable

    end

    it "won't change the database if movie isn't available" do
      movie = movies(:two)
      title = movie.title

      post checkout_path(title), params: {rental: rental_data}

      updated = Movie.find_by_title(title)
      updated.available_inv.must_equal movie.available_inv
    end

    it "handles appropriately if customer_id does not exist" do
      post checkout_path(movies(:one).title), params: {rental: bad_rental_data}
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body["errors"].must_equal "customer"=>["The Customer ID does not exist"]
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

    it "should only check in a rental one time" do
      Rental.destroy_all

      #checkout one movie, check that back in. Won't chekin again.
      post checkout_path(movies(:one).title), params: {rental: rental_data}
      post checkin_path(movies(:one).title), params: {rental: rental_data}

      post checkin_path(movies(:one).title), params: {rental: rental_data}

      must_respond_with :not_found
      body = JSON.parse(response.body)
      body["errors"].must_equal "rental"=>["Rental not found"]
    end

    it "should update the available inventory for that movie" do
      checkedout = movies(:one)
      title = checkedout.title

      post checkin_path(title), params: {rental: rental_data}

      updated = Movie.find_by_title(title)
      updated.available_inv.must_equal (checkedout.available_inv + 1)
    end

    it "updates movies_checked_out_count for that customer" do
      id = customers(:one).id

      checked_out = customers(:one).movies_checked_out_count
      post checkin_path(movies(:one).title), params: {rental: rental_data}

      customer = Customer.find_by_id(id)
      customer.movies_checked_out_count.must_equal (checked_out - 1)
    end

    it "should update the status of that rental" do
      rental = rentals(:checkedout)

      old_status = rental.status

      post checkin_path(movies(:one).title), params: {rental: rental_data}

      new_status = Rental.last.status

      old_status.wont_equal new_status
    end

    it "if Movie not found, return appropriate error & message" do
      title = "Bad Title"
      post checkin_path(title), params: {rental: rental_data}

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body["errors"].must_equal "movie"=>["#{title} not found"]
    end

    it "if Rental not found, return error and should not update database" do
      #there is no rental fixture with movie two.
      movie = movies(:two)
      title = movie.title

      post checkin_path(title), params: {rental: rental_data}

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body["errors"].must_equal "rental"=>["Rental not found"]

      not_updated = Movie.find_by_title(title)
      not_updated.available_inv.must_equal movies(:two).available_inv
    end

    it "shoult not increase the movie.available_inv to be more than inventory" do
      title = movies(:has_too_much_inventory).title
      post checkin_path(title), params: {rental: rental_data}

      must_respond_with :not_found
      body = JSON.parse(response.body)
      body["errors"].must_equal "rental"=>["This rental will over increase our inventory"]
    end
  end

  describe "overdue" do

    it "is a working route" do
      get overdue_url
      must_respond_with :success
    end

    it "returns an array of JSON objects" do
      get overdue_url
      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all movies that are overdue" do
      get overdue_url
      body = JSON.parse(response.body)
      body.length.must_equal Rental.overdue.count
    end

    it "returns required fields" do
      required_keys = %w(customer_id due_date info_for_overdues)

      get overdue_url
      body = JSON.parse(response.body)

      body.each do |rental|
        rental.keys.sort.must_equal required_keys
      end
    end

    it "handles appropriately if no rentals are expired" do
      Rental.destroy_all
      get overdue_url

      body = JSON.parse(response.body)
      must_respond_with :not_found

      body["errors"].must_equal "rentals"=>["No Overdue Rentals"]
    end
  end
end
