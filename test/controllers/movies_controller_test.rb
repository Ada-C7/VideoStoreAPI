require 'test_helper'

describe MoviesController do
    describe 'index' do
        it 'is a working route' do
            get movies_path
            must_respond_with :success
        end

        it 'returns json' do
            get movies_path
            response.header['Content-Type'].must_include 'json'
        end

        it 'returns an Array' do
            get movies_path

            body = JSON.parse(response.body)
            body.must_be_kind_of Array
        end

        it 'returns all of the movies' do
            get movies_path

            body = JSON.parse(response.body)
            body.length.must_equal Movie.count
        end

        it 'returns movies with exactly the required fields' do
            keys = %w(id release_date title)
            get movies_path

            body = JSON.parse(response.body)
            body.each do |movie|
                movie.keys.sort.must_equal keys
            end
        end
    end

    describe 'show' do
        it 'can get a movie' do
            get movie_path(movies(:one).title)
            must_respond_with :success
        end

        it 'returns movie with exactly the required fields' do
            keys = %w(available_inventory inventory overview release_date title)
            get movie_path(movies(:two).title)

            body = JSON.parse(response.body)
            body.keys.sort.must_equal keys
        end

        it 'returns 404 not found if movie does not exsist' do
            get movie_path('No movie has this bogus title say Queen Tofu the fluff')
            must_respond_with :not_found
        end
    end
end
