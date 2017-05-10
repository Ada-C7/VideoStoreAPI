require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:rental2) {Rental.new(customer_id: customers(:one).id, movie_id: movies(:one).id, due_date: "2017-05-10" )}

  RENTAL_VALIDATIONS = %w( customer_id movie_id due_date)

  it ' Will create a new rental with valid inputs' do
    rental2.save.must_equal true
    rental2.customer_id.must_equal customers(:one).id
    rental2.movie_id.must_equal movies(:one).id
    rental2.due_date.must_equal DateTime.parse("2017-05-10")
  end


  it " Won't create a rental without validated information" do
    rental.save.must_equal false
  end


  it " Customers must be present " do
    rental2.customer_id = nil
    rental2.valid?.must_equal false
    rental2.errors.messages.must_include :customer
  end

  it " Movie must be present " do
    rental2.movie_id = nil
    rental2.valid?.must_equal false
    rental2.errors.messages.must_include :movie
  end

  it " Due date must be present " do
    rental2.due_date = nil
    rental2.valid?.must_equal false
    rental2.errors.messages.must_include :due_date
  end

  describe "Rental Relationships" do

    it "Has access to customer object" do
      rental2.customer.must_be_instance_of Customer
      rental2.customer.phone.present?.must_equal true
      rental2.customer.phone.must_equal customers(:one).phone
    end

    it " Has access to movie object" do
      rental2.movie.must_be_instance_of Movie
      rental2.movie.title.present?.must_equal true
      rental2.movie.title.must_equal movies(:one).title
    end
  end

  describe "custom methods" do

    it ' Returns list of checked out movies based on movie id ' do
    Rental.checked_out(movies(:one).id).length.must_equal 2
    Rental.checked_out(movies(:one).id).must_include rentals(:one)
    end

    it ' Returns empty array when no movie(s) is/are checked out match the id that was passed ' do

      Rental.checked_out(movies(:three).id).must_equal []
    end

    it 'returns nil when no id matches ' do

      Rental.checked_out(Movie.last.id + 1).must_equal nil
    end
   end
end
