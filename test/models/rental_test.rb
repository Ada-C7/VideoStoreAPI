require "test_helper"

describe Rental do
  describe "relations" do
    it "has the correct customer" do
      rental = rentals(:one)
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
      rental.customer.name.must_equal "Shelley Rocha"
    end

    it "has the correct movie" do
      rental = rentals(:one)
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
      rental.movie.title.must_equal "Psycho"
    end
  end

  describe "validations" do
    it "requires a due_date" do
      rental = Rental.new
      rental.valid?.must_equal false
      rental.errors.messages.must_include :due_date
    end

    it "can be created with a due_date" do
      psycho = movies(:psycho)
      shelley = customers(:shelley)

      rental = Rental.new(due_date: Date.today, customer: shelley, movie: psycho)
      rental.valid?.must_equal true
      rental.save
      Rental.last.must_equal rental
    end
  end


  describe "overdue" do
    it "returns an array of rentals" do
      rentals = Rental.overdue
      rentals.must_be_kind_of Array

      rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it "returns an empty array if no rentals are overdue" do

      all_rentals = Rental.all
      all_rentals.each do |rental|
        rental.checked_out = false
        rental.save
      end

      rentals = Rental.overdue
      rentals.must_be_kind_of Array
      rentals.empty?.must_equal true
    end
  end


end
