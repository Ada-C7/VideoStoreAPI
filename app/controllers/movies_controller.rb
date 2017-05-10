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

    def checkout
        @movie = Movie.find_by(title: params[:title])
        @customer = Customer.find_by(id: params[:customer_id])

        if Rental.find_by(movie_id: @movie.id, customer_id: @customer.id)
            render status: :not_found
        else

            new_availability = @movie.available_inventory -= 1
            @movie.update_attribute(:available_inventory, new_availability)

            @rental = Rental.new(movie_id: @movie.id, customer_id: @customer.id, checkout_date: Time.now, due_date: Time.now + 3.days)

            customer_movie_count = @customer.movies.length
            @customer.update_attribute(:movies_checked_out_count, customer_movie_count)

            if @rental.save
                render json: @rental.as_json(only: [:customer_id, :due_date]), status: :ok
            else
                render status: :bad_request
            end
        end
    end

    def checkin
        @movie = Movie.find_by(title: params[:title])
        @customer = Customer.find_by(id: params[:customer_id])
        @rental = Rental.find_by(movie_id: @movie.id, customer_id: @customer.id)

        if @customer.movies.any? { |movie| movie.title == @movie.title }
            new_availability = @movie.available_inventory += 1
            @movie.update_attribute(:available_inventory, new_availability)

            customer_movie_count = @customer.movies.length
            @customer.update_attribute(:movies_checked_out_count, customer_movie_count)

            render json: @rental.as_json(only: [:customer_id]), status: :ok
            @rental.destroy
        else
            render status: :bad_request
        end
    end
end
