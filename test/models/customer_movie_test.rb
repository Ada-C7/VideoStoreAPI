require "test_helper"

describe CustomerMovie do
  describe 'relations' do
    it 'rental can only have one movie' do
      rental = customer_movies(:one)
      # rental.must_repsond_to :movie
      assert_equal 1,  rental.movie.id
    end

    it 'rental can only have one customer' do
      rental = customer_movies(:one)
      # rental.must_repsond_to :movie
      assert_equal 1,  rental.customer.id
    end
  end
end
