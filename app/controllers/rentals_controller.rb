class RentalsController < ApplicationController

    def checkout
      movie_id = Movie.find_by_title(params[:title]).id
      rental_params[:movie_id] = movie_id
      rental_params[:checkout_date] = Date.today
      rental_params[:due_date] = rental_params[:checkout_date] + 7
      rental = Rental.new(rental_params)

      if rental.save

      else
        
      end

    end

    def checkin
      # parameters: title
      # request customer_id

    end

    def overdue
      # return list of rentals
      # return title, customer_id, name, postal_code, checkout_date, due_date
    end

    private

    def rental_params
      params.require(:rental).permit(:customer_id)
    end

end
