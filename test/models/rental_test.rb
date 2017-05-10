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

end
