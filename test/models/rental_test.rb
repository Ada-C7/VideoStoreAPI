require "test_helper"

describe Rental do
  # let(:rental) { Rental.new }
  let(:rental) {Rental.new(due_date: DateTime.now, customer_id: customers(:one).id, movie_id: movies(:one).id)}

  describe "Validations" do

    it "Rental will be crated with valid inputs" do
      # customer = customers(:one)
      # movie = movies(:one)

      rental.valid?.must_equal true

      rental.customer_id.must_equal customers(:one).id
      rental.movie_id.must_equal movies(:one).id
      # rental.due_date.must_equal DateTime.parse('YYYY-MM-DD')

    end

    it "Rental can't be created without  customer_id" do
      movie = movies(:one)
      rental = Rental.new(due_date: nil, movie_id: movie.id)

      rental.valid?.must_equal false
      rental.errors.messages.must_include :customer_id
    end

    it "Rental can't be created without  due_date" do
      customer = customers(:one)
      movie = movies(:one)
      rental = Rental.new(due_date: nil, customer_id: customer.id, movie_id: movie.id)

      rental.valid?.must_equal false
      rental.errors.messages.must_include :due_date
    end

    it "Rental can't be created without  movie_id" do
      customer = customers(:one)
      rental = Rental.new(due_date: nil, customer_id: customer.id)

      rental.valid?.must_equal false
      rental.errors.messages.must_include :movie_id
    end

    describe "Relations" do

      it "Rental has the corret customer" do
        rental.must_respond_to :customer
        rental.customer.must_be_kind_of Customer
      end

      it "Rental has the corret movie" do
        rental.must_respond_to :movie
        rental.movie.must_be_kind_of Movie
      end

    end
  end
end
