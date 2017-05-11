require "test_helper"

describe RentalsController do
  describe "checkout method" do
    it "can check out a movie" do
      movie_title = movies(:jaws).title
      first_count = Rental.count
      customer_id = customers(:curran).id
      rental_params = {
        rental: {
          customer_id: customer_id,
          due_date: "2017-07-01"
        }
      }
      post new_rental_path(movie_title), params: rental_params
      # byebug
      must_respond_with :success

      last_count = Rental.count
      first_count.must_equal last_count - 1
    end

    it "won't check out a movie that doesn't exist" do
      movie_title = "fred"
      first_count = Rental.count
      customer_id = customers(:curran).id
      rental_params = {
        rental: {
          customer_id: customer_id,
          due_date: "2017-07-01"
        }
      }
      post new_rental_path(movie_title), params: rental_params
      must_respond_with :bad_request
      last_count = Rental.count
      first_count.must_equal last_count
    end
    end


    it "won't check out a movie if a customer doesn't exist" do
      movie = movies(:jaws)
      first_count = Rental.count
      customer_id = Customer.last.id + 1
      rental_params = {
        rental: {
          customer_id: customer_id,
          due_date: "2017-07-01"
        }
      }
      post new_rental_path(movie.title), params: rental_params
      must_respond_with :bad_request
      last_count = Rental.count
      first_count.must_equal last_count
    end
  end


  describe "checkin method" do
    it "can check in a checked_out rental" do
      title = rentals(:one).movie.title
      id = customers(:shelley).id
      rental = rentals(:one)
      rental.checked_out.must_equal true

      rental_params = {
        rental: {
          customer_id: id,
        }
      }

      patch check_in_rental_path(title),  params: rental_params
      must_respond_with :success
      rental.reload
      rental.checked_out.must_equal false
    end

      it "gives an approriate error message and status bad request if given bad information" do
      #Given bad movie title
      title = 'bogus movie'
      id = customers(:shelley).id

      rental_params = {
        rental: {
          customer_id: id,
        }
      }

      patch check_in_rental_path(title),  params: rental_params
      must_respond_with :bad_request



  end
end
