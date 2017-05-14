class RentalsController < ApplicationController

  def overdue
    if Rental.all.nil?
      render json: {errors: "No rentals found"}, status: :not_found
    else
      if params[:sort] == "title"
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).joins(:movie).merge(Movie.order(:title))
      elsif params[:sort] == "name"
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).joins(:customer).merge(Customer.order(:name))
      elsif params[:sort] == "checkout_date"
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).order(:created_at)
      elsif params[:sort] == "due_date"
        Rental.all.each do |rental|
          rental.due_date.to_time
          rental.save
        end
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).order(:due_date)
      end
    end

    rentals = Rental.paginate(page: params[:p], per_page: params[:n]) if rentals.nil?
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
