require "test_helper"

describe RentalsController do
  describe "checkout method" do
    it "can check out a movie" do
    end

    it "won't check out a movie that doesn't exist" do
    end


    it "won't check out a movie if a customer doesn't exist" do
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
end
