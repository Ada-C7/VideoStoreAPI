require 'test_helper'

describe Rental do
    describe 'associations/relation' do
        it 'belongs to customers' do
            ar = Rental.reflect_on_association(:customer)
            ar.macro.must_equal :belongs_to
        end
        it 'belongs to movies' do
            ar = Rental.reflect_on_association(:movie)
            ar.macro.must_equal :belongs_to
        end
    end

    describe 'validations' do
        it 'is invalid without a movie id' do
            rental = Rental.new(customer_id: 1, checkout_date: Time.now, due_date: Time.now + 3)
            result = rental.valid?
            result.must_equal false

            rental.errors.messages.must_include :movie_id
        end

        it 'is invalid without a customer id' do
            rental = Rental.new(movie_id: 1, checkout_date: Time.now, due_date: Time.now + 3)
            result = rental.valid?
            result.must_equal false

            rental.errors.messages.must_include :customer_id
        end

        it 'is invalid without a checkout date' do
            rental = Rental.new(customer_id: 1, movie_id: 2, due_date: Time.now + 3)
            result = rental.valid?
            result.must_equal false

            rental.errors.messages.must_include :checkout_date
        end

        it 'is invalid without a due date' do
            rental = Rental.new(customer_id: 1, checkout_date: Time.now, movie_id: 3)
            result = rental.valid?
            result.must_equal false

            rental.errors.messages.must_include :due_date
        end
    end
end
