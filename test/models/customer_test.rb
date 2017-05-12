require 'test_helper'

describe Customer do
    describe 'associations/relation' do
        it 'has many movies through rentals' do
            ar = Customer.reflect_on_association(:movies)
            ar.macro.must_equal :has_many
        end
        it 'has many rentals' do
            ar = Customer.reflect_on_association(:rentals)
            ar.macro.must_equal :has_many
        end
    end
end
