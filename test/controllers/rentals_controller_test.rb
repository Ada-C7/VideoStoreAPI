require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "a real working route" do
      customer = customers(:stout)
      movie = movies(:jaws)
      post checkout_path(customer_id: customer.id, title: movie.title, due_date: "2017-09-12")
      must_respond_with :success
    end

    it "decreases the available inventory by one if the movie is found and the avialable inventory is more than 0" do
      customer = customers(:stout)
      movie = movies(:jaws)
      initial_inventory = movie.available_inventory

      post checkout_path(customer_id: customer.id, title: movie.title, due_date: "2017-09-12")
      new_inventory = movie.available_inventory
      
      must_respond_with :success
      new_inventory.must_equal initial_inventory - 1
    end

    it "renders a bad request status if the available inventory is less than 0" do skip
      customer = customers(:stout)
      movie = Movie.new(title: "jaws", overview: "here is an overview", release_date: "1960-06-16", inventory: 0)

      post checkout_path(customer_id: customer.id, title: movie.title, due_date: "2017-09-12")
      # post checkout_path(customer_id: customer.id, title: movie.title, due_date: "2017-09-11")

      must_respond_with :bad_request

    end

    it "renders a status ok if the rental is succesffully created" do
    end

    it "renders a bad request if the rental wasn't saved" do skip
      # customer = customers(:stout)
      # post checkout_path(customer_id: customer.id, title: "", due_date: "2017-09-12")
      Rental.new(customer_id: 1)
      must_respond_with :bad_request
    end

  end
    describe "checkin" do
      # customer = customers(:stout)
      # movie = movies(:jaws)
      # due_date = "2018-08-03"
      # post checkout_url(customer_id: customer, title: movie.title, due_date: due_date)
      it "responds with success when params are valid and movie is checkouted" do
        rental = rentals(:one)
        rental.returned.must_equal false

        post checkin_url(customer_id: rental.customer, title: rental.movie.title)
        must_respond_with :success
        # rental.returned.must_equal true
      end

      it "increases a movie's available inventory when it's checked back in" do
        rental = rentals(:one)
        rental.returned.must_equal false
        initial_inventory = rental.movie.available_inventory

        post checkin_url(customer_id: rental.customer, title: rental.movie.title)
        adjusted_inventory = rental.movie.available_inventory

        adjusted_inventory.must_equal initial_inventory + 1
      end

      it "responds with bad_request when params are valid but no movie is checkout" do
        rental = rentals(:three)
        rental.returned.must_equal true

        post checkin_url(customer_id: rental.customer, title: rental.movie.title)
        must_respond_with :bad_request
        rental.returned.must_equal false
      end

      it "responds with bad_request when given an invalid movie title" do
        rental = rentals(:one)
        rental.returned.must_equal false

        post checkin_url(customer_id: rental.customer, title: "Test title")
        must_respond_with :bad_request
        rental.returned.must_equal false
      end

      it "responds with bad_request when given an invalid customer_id" do
        rental = rentals(:one)
        rental.returned.must_equal false

        post checkin_url(customer_id: Customer.last.id + 1, title: rental.movie.title)
        must_respond_with :bad_request
        rental.returned.must_equal false
      end

      it "does not modify the available_inventory of a movie if given a bad request" do
        rental = rentals(:one)
        rental.returned.must_equal false
        initial_inventory = rental.movie.available_inventory

        post checkin_url(customer_id: Customer.last.id + 1, title: rental.movie.title)
        adjusted_inventory = rental.movie.available_inventory

        adjusted_inventory.must_equal initial_inventory
      end

      # it "allows a customer to return a movie that they have checkout for a 2nd time" do
      #   rental = rentals(:one)
      #   rental.returned.must_equal false
      #   post checkin_url(customer_id: rental.customer, title: rental.movie.title)
      #   rental.returned.must_equal true
      #
      #   post checkout_url(customer_id: rental.customer, title: rental.movie.title, due_date: "2017-08-03")
      #   rental.returned.must_equal false
      #
      #   post checkin_url(customer_id: rental.customer, title: rental.movie.title)
      #   must_respond_with :success
      #   rental.returned.must_equal true
      # end

      # customer can return two copies of the same movie
      # customer can return a movie that they have checked out for the second time
      # if current rental not found, returns json erorr
  end
end
