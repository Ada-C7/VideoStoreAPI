class MoviesController < ApplicationController
    def index
        @movies = Movie.all
        render json: @movies.as_json(only: [:id, :title, :release_date]), status: :ok
    end

    def show
        @movie = Movie.find_by(title: params[:title])

        if @movie.nil?
            render json: {}, status: :not_found
        else
            render json: @movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
        end
    end

    def checkout(customer_id)
        @movie = Movie.find_by(title: params[:title])
        @customer = Customer.find_by(id: customer_id)

        @movie.available_inventory -= 1

        @rental = Rental.create(movie_id: @movie.id, customer_id: @customer.id, checkout_date: Time.now, due_date: Time.now + 3.days)

        @customer.movies_checked_out_count = @customer.movies.length

        render json: @rental.as_json(only: [:customer_id, :due_date])
    end
end
