require "test_helper"

describe Rental do

  describe "Relationships" do

    it "must belong to a movie" do
      rental = rentals(:rental_one)
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
    end

    it "must belong to a customer" do
      rental = rentals(:rental_one)
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
    end

  end

  describe "required fields" do

    REQUIRED_FIELDS = %w(due_date created_at movie_id customer_id)

    REQUIRED_FIELDS.each do | field |

      it "a rentals must have a #{field}" do

      end

    end

  end

  describe "numericality fields" do

    NUMERICALITY_FIELDS = %w(movie_id customer_id)

  end

end
