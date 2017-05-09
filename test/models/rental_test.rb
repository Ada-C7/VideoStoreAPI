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

end
