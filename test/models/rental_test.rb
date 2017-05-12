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

  describe "Validations" do

    let (:new_rental) { Rental.new(
      due_date: "12/12/14",
      movie_id: 2,
      customer_id: 2
      )
    }

    REQUIRED_FIELDS = %w(due_date movie_id customer_id)
    NUMERICALITY_FIELDS = %w(movie_id customer_id)

    REQUIRED_FIELDS.each do | field |
      it "a rentals must have a #{field}" do
        new_rental[field] = nil
        new_rental.valid?.must_equal false
        new_rental.errors.messages.must_include field.to_sym
      end
    end

    NUMERICALITY_FIELDS.each do | field |
      it "#{field} must be a number" do
        new_rental[field] = "zero"
        new_rental.valid?.must_equal false
        new_rental.errors.messages.must_include field.to_sym
      end
    end

    it "False is the default value for returned" do
      new_rental.returned.must_equal false
    end

  end

end
