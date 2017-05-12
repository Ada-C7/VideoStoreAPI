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

    describe 'validations' do
        it 'is invalid without a name' do
            customer = Customer.new(registered_at: '2017-5-19')
            result = customer.valid?
            result.must_equal false

            customer.errors.messages.must_include :name
        end
        it 'is invalid without registration date' do
            customer = Customer.new(name: 'Tofu')
            result = customer.valid?
            result.must_equal false

            customer.errors.messages.must_include :registered_at
        end
    end
end
