class RentalsController < ApplicationController
  def create
    rental_info = rental_params
    rental_info[:title] = params[:title]
    rental = Rental.new(rental_info)
    if rental.save
      render status: :ok, json: {id: rental.id}
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def update
    movie = Movie.find_by(title: params[:title] )
    rental = Rental.find_by(movie_id: movie.id, customer_id: rental_params[:customer_id], returned: false)
    if rental
      rental.returned = true
      if rental.save
        render status: :ok, json: { movie_returned: true }
      end
    elsif Rental.find_by(movie_id: movie.id, customer_id: rental_params[:customer_id], returned: true)
      render status: :bad_request, json: { errors: { check_in: "Customer has already checked in this movie"}}
    else
      render status: :bad_request, json: { errors: { check_in: "Cannot find this rental"} }
    end
  end

  def overdue
    #what is the syntax for a conditional for due date?
    rentals = Rental.where("returned = ? AND due_date <= ?", false, Date.current)
    if rentals
      #array of customer ids for customers who have overdue rentals
      customer_ids = rentals.map { |rental| rental.customer_id }

      overdue_rentals = []
      customer_ids.each do |id|
        customer = Customer.find_by_id(id)
        hash = Hash.new
        hash[:name] = customer.name
        hash[:customer_id]  = id
        hash[:postal_code] = customer.postal_code

        rentals = []
        customer.rentals.each do |rental|
          rental_hash = Hash.new
          rental_hash[:title] = Movie.find_by_id(rental.movie_id).title
          rental_hash[:checkout_date] = rental.created_at.to_date
          rental_hash[:due_date] = rental.due_date
          rentals << rental_hash
        end
        hash[:rentals] = rentals
        overdue_rentals << hash
      end
      render status: :ok, json: overdue_rentals.as_json
    else
      render status: :bad_request, json: { overdue: "There are no overdue rentals" }
    end

  end

  private

  def rental_params
    params.require(:rental).permit(:due_date, :customer_id)
  end

end
