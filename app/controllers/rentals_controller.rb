class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    rental.movie =  Movie.find_by(title: params[:title])
    rental.checked_out = true
    if rental.save
      render status: :ok, json: { id: rental.id }
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def checkin
    movie =  Movie.find_by(title: params[:title])
    if movie.nil?
      render status: :bad_request, json: { error: "#{params[:title]} could not be found, so we could not check in your rental." }
    else


      customer_id = rental_params[:customer_id]
      rentals = Rental.where(movie_id: movie.id, customer_id: customer_id, checked_out: true)
      rental = rentals[0]
      if rental.nil?
        render status: :bad_request, json: { error: "There was a problem. Could not check in your movie." }
      else
        rental.checked_out = false
        rental.save
        render status: :ok, json: { id: rental.id }
      end
    end
  end


  def overdue
    overdue_rentals = Rental.overdue

    if overdue_rentals.length > 0

      if  params[:sort] == "due_date"
        overdue_rentals = Rental.order(params[:sort].to_sym).overdue
      elsif params[:sort] == "title"
        overdue_rentals = Rental.joins(:movie).merge(Movie.order(:title)).overdue
      elsif params[:sort] == "name"
        overdue_rentals = Rental.joins(:customer).merge(Customer.order(:name)).overdue
      elsif params[:sort] == "checkout_date"
        overdue_rentals = Rental.order(:created_at).overdue
      end

      render :json => overdue_rentals, status: :ok

    else
      render :json => {no_overdue_rentals: "There are no overdue rentals."}, status: :not_found

    end
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end

end
