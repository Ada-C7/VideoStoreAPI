class RentalsController < ApplicationController
  def zomg
    render json: {Message: "it works!"}, status: :ok
  end

  def overdue
    if Rental.all.empty?
      render json: {errors: "No rentals found"}, status: :not_found
      return
    else
      if params[:sort] == "title"
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).joins(:movie).merge(Movie.order(:title))
      elsif params[:sort] == "name"
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).joins(:customer).merge(Customer.order(:name))
      elsif params[:sort] == "checkout_date"
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).order(:created_at)
      elsif params[:sort] == "due_date"
        rentals = Rental.paginate(page: params[:p], per_page: params[:n]).order(:due_date)
      end
    end

    rentals = Rental.paginate(page: params[:p], per_page: params[:n]) if rentals.nil?

    current_rentals = rentals.where(returned_date: nil)
    if current_rentals.empty?
      render json: {errors: "No current rentals"}, status: :not_found
      return
    else
      rentals = current_rentals.where("due_date < ?", Time.now)
    end

    if rentals.empty?
      render json: {errors: "No Customers with Overdue Movies"}, status: :not_found
    else
      render json: rentals, status: :ok
    end

  end
end
