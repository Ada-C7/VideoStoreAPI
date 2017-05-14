class RentalsController < ApplicationController

  def overdue
    if Rental.all.nil?
      render json: {errors: "No rentals found"}, status: :not_found
    else
      if params[:sort] == "title"
        rentals = Rental.joins(:movie).merge(Movie.order(:title))
      elsif params[:sort] == "name"
        rentals = Rental.joins(:customer).merge(Customer.order(:name))
      elsif params[:sort] == "checkout_date"
        rentals = Rental.order(:created_at)
      elsif params[:sort] == "due_date"
        Rental.all.each do |rental|
          rental.due_date.to_time
        end
        rentals = Rental.order(:due_date)
        return rentals
      end
    end
    current_rentals = rentals.where(returned_date: nil)
    if current_rentals.nil?
      render json: {errors: "No current rentals"}, status: :not_found
    end
  
    rentals = current_rentals.where("due_date < ?", Time.now)


    if rentals.nil?
      render json: {errors: "No Customers with Overdue Movies"}, status: :not_found
    end

    render json: rentals, status: :ok#, each_serializer: OverdueSerializer

  end
end
