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

    describe 'checkout' do
        it 'can checkout a movie and update movies and customers' do
            movie_inventory = movies(:one).available_inventory - 1
            customer_movies = customers(:one).movies.length + 1

            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)
            must_respond_with :success

            movies(:one).reload

            movies(:one).available_inventory.must_equal movie_inventory
            customers(:one).movies.count.must_equal customer_movies
        end

        it 'wont allow a customer to checkout the same movie twice' do
            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)
            customer_movies = customers(:one).movies.count

            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)
            must_respond_with :bad_request

            customers(:one).movies.count.must_equal customer_movies
        end

        it 'wont allow customer to checkout if no available inventory' do
            post checkout_path(customer_id: customers(:one).id, title: movies(:three).title)

            post checkout_path(customer_id: customers(:two).id, title: movies(:three).title)
            customers(:two).movies.count.must_equal 0
        end

        it 'creates a Rental if valid' do
            first_rental_count = Rental.count

            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)

            Rental.count.must_equal first_rental_count + 1
        end

        it 'returns json' do
            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)
            response.header['Content-Type'].must_include 'json'
        end

        it 'returns a Hash' do
            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)

            body = JSON.parse(response.body)
            body.must_be_kind_of Hash
        end

        it 'returns rental with exactly the required fields' do
            keys = %w(customer_id due_date)
            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)

            body = JSON.parse(response.body)
            body.keys.sort.must_equal keys
        end
    end

    describe 'checkin' do
        before do
            @movie_inventory = movies(:one).available_inventory
            @customer_movies = customers(:one).movies.length
            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)
        end
        it 'can checkin a movie' do
            movies(:one).reload
            movies(:one).available_inventory.wont_equal @movie_inventory

            post checkin_path(customer_id: customers(:one).id, title: movies(:one).title)
            must_respond_with :success

            movies(:one).reload

            movies(:one).available_inventory.must_equal @movie_inventory
            customers(:one).movies.count.must_equal @customer_movies
        end

        it 'wont allow a customer to checkin the same movie twice' do
            post checkin_path(customer_id: customers(:one).id, title: movies(:one).title)
            customer_movies = customers(:one).movies.count

            post checkin_path(customer_id: customers(:one).id, title: movies(:one).title)
            must_respond_with :bad_request

            customers(:one).movies.count.must_equal customer_movies
        end

        it 'destroys a Rental if valid' do
            first_rental_count = Rental.count

            post checkin_path(customer_id: customers(:one).id, title: movies(:one).title)

            Rental.count.must_equal first_rental_count - 1
        end

        it 'returns json' do
            post checkin_path(customer_id: customers(:one).id, title: movies(:one).title)
            response.header['Content-Type'].must_include 'json'
        end

        it 'returns a Hash' do
            post checkin_path(customer_id: customers(:one).id, title: movies(:one).title)

            body = JSON.parse(response.body)
            body.must_be_kind_of Hash
        end

        it 'returns rental with exactly the required fields' do
            keys = %w(customer_id)
            post checkout_path(customer_id: customers(:one).id, title: movies(:one).title)
            post checkin_path(customer_id: customers(:one).id, title: movies(:one).title)

            body = JSON.parse(response.body)
            body.keys.sort.must_equal keys
        end
    end
end
