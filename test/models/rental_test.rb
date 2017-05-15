require "test_helper"

describe Rental do
  # let(:rental) { Rental.new }
  describe "relationships" do
    it "has a customer" do
      rental = rentals(:rental_one)
      rental.customer.name.must_equal "one"
    end

    it "has a movie" do
      rental = rentals(:rental_one)
      rental.movie.title.must_equal "Tusk"
    end
  end

  describe "validations" do
    it "creates a rental with a movie and a customer" do
      start_count = Rental.all.length
      rental = Rental.create(customer_id:1, movie_id: 3)
      Rental.all.length.must_equal start_count
    end

    it "doesn't create a rental without a movie" do
      start_count = Rental.all.length
      rental = Rental.create
      Rental.all.length.must_equal start_count
    end

    it "doesn't create a rental without a customer" do
      start_count = Rental.all.length
      rental = Rental.create
      Rental.all.length.must_equal start_count
    end

    it "doesn't create a rental without a movie and a customer" do
      start_count = Rental.all.length
      rental = Rental.create
      Rental.all.length.must_equal start_count
    end
  end

  describe "checkout_date" do
    it "returns overdue movie's checkout date" do
      rental = rentals(:rental_two)
      rental.checkout_date.must_be_instance_of Date
    end
  end

  describe "title" do
    it "returns overdue movie's title" do
      rental = rentals(:rental_two)
      rental.title.must_equal "Little Mermaid"
    end
  end

  describe "name" do
    it "returns the customer's name with the overdue movie" do
    rental = rentals(:rental_two)
    rental.name.must_equal "two"
    end
  end
  #
  describe "postal_code" do
    it "returns the overdue customer's postal code" do
    rental = rentals(:rental_two)
    rental.postal_code.must_equal "97611"
    end
  end

end
