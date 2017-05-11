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
end
