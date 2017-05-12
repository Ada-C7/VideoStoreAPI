class RentalsController < ApplicationController

    def checkout
        #add method to check if there is enough in available_inventory
        rental = Rental.new
        rental.movie = Movie.find_by_title(params[:title])
        rental.customer = Customer.find_by_id(params[:rental][:customer_id])

        # we decided to automatically set the checkout date to the day the request is posted
        rental.checkout_date = Date.today
        rental.due_date = Date.today + 7
        rental.checked_out = true
        rental.movie.available_inventory -= 1

        if rental.save && rental.movie.save
            render json: { id: rental.id, checked_out: rental.checked_out }, status: :ok
        else
            render json: { errors: rental.errors.messages }, status: :bad_request
        end

    end

    def checkin
        movie_id = Movie.find_by_title(params[:title]).id
        customer_id = Customer.find_by_id(params[:rental][:customer_id])
        rental = Rental.find_by_movie_id_and_customer_id(movie_id, customer_id)
        if rental
            rental.checked_out = false
            rental.movie.available_inventory += 1

            if rental.save && rental.movie.save
                render json: { id: rental.id, checked_out: rental.checked_out }, status: :ok
            end
        else
            render json: { errors: "could not find rental" }, status: :bad_request
        end
    end

    def overdue
        rentals = Rental.overdue
        render json: rentals.as_json(only: [:customer_id, :checkout_date, :due_date], methods: [:title, :name, :postal_code]), status: :ok
    end

end
