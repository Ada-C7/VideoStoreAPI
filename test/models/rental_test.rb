require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "requires a movie, customer and due date to create" do
    rental.valid?.must_equal false
  end

  it "can be created with valid customer, movie and due date" do
    rental.customer = customers(:one)
    rental.movie = movies(:one)
    rental.due_date = "1/1/18"

    rental.save.must_equal true
  end

  describe "Rental#Overdue" do
    let(:overdues) {Rental.overdue}

    it "should return an array of rentals" do
      overdues.must_be_instance_of Array
      overdues.each do |rental|
        rental.must_be_instance_of Rental
      end
    end

    it "Each rental's due date should be before today's date" do
      overdues.each do |rental|
        due = Date.parse (rental.due_date)
        due.past?.must_equal true
      end
    end

    it "If there are no overdue rentals, should return an empty array" do
      #deleted all from test database
      Rental.destroy_all

      #created one future due rental
      rental_hash = {customer_id: 1, movie_id: 1, due_date: (Time.now + 5.days)}
      Rental.create(rental_hash)

      #check that none show up
      Rental.overdue.must_equal []
    end

    it "If a rental's due date is today, should not be returned" do
      overdues.wont_include (rentals(:one))
    end
  end

  describe "Rental#info_for_overdues" do
    let(:rental) {rentals(:one)}
    let(:customer) {customers(:one)}
    let(:movie) {movies(:one)}

    it "returns a hash of rental info" do
      rental.info_for_overdues.must_be_instance_of Hash
    end

    it "returns correct info for rental" do
      rental_info_hash = rental.info_for_overdues

      rental_info_hash["title"].must_equal movie.title
      rental_info_hash["name"].must_equal customer.name
      rental_info_hash["postal_code"].must_equal customer.postal_code
      rental_info_hash["checkout_date"].must_equal rental.created_at
    end
  end
end
