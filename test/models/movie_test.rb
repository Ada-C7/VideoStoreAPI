require 'test_helper'

describe Movie do
    describe 'associations/relation' do
        it 'has many customers' do
            ar = Movie.reflect_on_association(:customers)
            ar.macro.must_equal :has_many
        end
        it 'has many rentals' do
            ar = Movie.reflect_on_association(:rentals)
            ar.macro.must_equal :has_many
        end
    end

    describe 'validations' do
        it 'is invalid without a title' do
            movie = Movie.new
            result = movie.valid?
            result.must_equal false

            movie.errors.messages.must_include :title
        end

        it 'wont allow inventory to be less than 0' do
            movie = Movie.new(title: 'Tofu the Fluff', inventory: -1)
            result = movie.valid?
            result.must_equal false

            movie.errors.messages.must_include :inventory
        end

        it 'only allows numbers for inventory' do
            movie = Movie.new(title: 'Tofu the Fluff', inventory: 'pizza')
            result = movie.valid?
            result.must_equal false

            movie.errors.messages.must_include :inventory
        end
    end
end
