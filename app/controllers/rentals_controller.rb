class RentalsController < ApplicationController

    def checkout
      rental = Rental.new
      rental.movie = Movie.find_by_title(params[:title])
      rental.customer = Customer.find_by_id(params[:rental][:customer_id])
      rental.checkout_date = Date.today
      rental.due_date = Date.today + 7

      if rental.save
        render json: { id: rental.id }, status: :ok
      else
        render json: { errors: rental.errors.messages }, status: :bad_request
      end

    end

    def checkin
      # parameters: title
      # request customer_id

    end

    def overdue
      # return list of rentals
      rentals = Rental.overdue?
      render json: rentals.as_json()
      # return title, customer_id, name, postal_code, checkout_date, due_date
    end

end
