require "test_helper"

describe RentalsController do
  describe "checkout" do

    it "returns a json object" do
      customer_id = customers(:alison).id
      post checkout_path("Doctor Strange"), params: { rental: {customer_id: customer_id } }
      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include 'id'

      Rental.find(body['id']).customer_id.must_equal customer_id
    end

    it "creates a new rental" do
      proc {
        post checkout_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
      }.must_change 'Rental.count', 1
      must_respond_with :success
    end

    it "has the correct movie, customer, checkout date, due date (a week away), checkout status of true" do
      movie_title = "Doctor Strange"
      customer_id = customers(:brenna).id

      post checkout_path(movie_title), params: { rental: { customer_id: customer_id } }
      rental = Rental.last
      rental.movie.title.must_equal movie_title
      rental.customer_id.must_equal customer_id
      rental.checkout_date.must_equal Date.today.strftime("%Y-%m-%d")
      rental.due_date.must_equal (Date.today + 7).strftime("%Y-%m-%d")
      rental.checked_out.must_equal true
    end

    it "changes the movie model's available_inventory when the movie is rented" do
      post checkout_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
      Rental.last.movie.available_inventory.must_equal 49
    end


    it "increases a customers movie count" do
        post checkout_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
        Rental.last.customer.movies_checked_out_count.must_equal 2
    end

    it "fails to create a rental with invalid input" do
        proc {
            post checkout_path("Doctor Strange"), params: { rental: { customer_id: -4 } }
        }.wont_change 'Rental.count'
        must_respond_with :bad_request
    end

  end

  describe "checkin" do
      before do
          post checkout_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
      end

    it "changes rental status" do
        post checkin_path("Doctor Strange"), params: { rental: { customer_id: 1} }
        movie_id = movies(:strange).id
        customer_id = customers(:alison).id
        rental = Rental.find_by_movie_id_and_customer_id(movie_id, customer_id)
        rental.checked_out.must_equal false
    end

    it "responds with success and doesn't change the rental count" do
        proc {
            post checkin_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
        }.wont_change 'Rental.count'
        must_respond_with :success
    end


    it "finds the correct rental" do
        post checkin_path("Doctor Strange"), params: { rental: { customer_id: 1} }
        rental = Rental.last
        rental.customer_id.must_equal 1
        rental.movie.title.must_equal "Doctor Strange"
    end

    it "changes available_inventory" do
        post checkin_path("Doctor Strange"), params: { rental: { customer_id: 1 } }
        Rental.last.movie.available_inventory.must_equal 50
    end


    it "if bad request, responds with bad request" do
        proc {
            post checkin_path("Doctor Strange"), params: { rental: { customer_id: -4 } }
        }.wont_change 'Rental.count'

        must_respond_with :bad_request
        body = JSON.parse(response.body)
        body.must_equal "errors" =>  "could not find rental"
    end

  end

  describe "overdue" do
    KEYS = %w(checkout_date customer_id due_date name postal_code title)

    it "returns array of overdue rentals" do
      get overdue_path
      must_respond_with :success
    end

    it "works if no overdue rentals" do
      Rental.all.each { |rental| rental.destroy }
      get overdue_path
      must_respond_with :success
    end

    it "returns JSON" do
      get overdue_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns correct fields in JSON" do
      get overdue_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.each do |rental|
        rental.keys.sort.must_equal KEYS
      end
    end

    it "all rentals in list are past due" do
      # could not figure out how to write this test
      skip
      get overdue_path
      body = JSON.parse(response.body)
      body.each do |rental|
        Date.strptime(rental[:due_date], "%Y-%m-%d").past?.must_equal true
      end
    end
  end
end
