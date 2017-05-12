class RentalsController < ApplicationController

    def checkout
        #add method to check if there is enough in available_inventory
        rental = Rental.new
        rental.movie = Movie.find_by_title(params[:title])
        rental.customer = Customer.find_by_id(params[:rental][:customer_id])
        rental.checkout_date = Date.today
        rental.due_date = Date.today + 7

        if rental.save
            render json: { id: rental.id }, status: :ok
            rental.movie.available_inventory -=1
            rental.checked_out = true
            rental.movie.save
        else
            render json: { errors: rental.errors.messages }, status: :bad_request
        end

    end

    def checkin
        movie = Movie.find_by_title(params[:title])
        customer = Customer.find_by_id(params[:customer][:id])
        rental = Rental.find_by_movie_id_and_customer_id(movie.id, customer.id)
        rental.checked_out = false
        rental.available_inventory +=1
        if rental.save
            render json: { id: rental.id }, status: :ok
        else
            render json: { errors: rental.errors.messages }, status: :bad_request    
        end
    end

    def overdue
        # return list of rentals
        rentals = Rental.overdue?
        render json: rentals.as_json()
        # return title, customer_id, name, postal_code, checkout_date, due_date
    end

end
