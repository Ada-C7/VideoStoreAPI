class RentalsController < ApplicationController

  def check_out
    movie = Movie.find_by_title(params[:title])

    if !movie

      render status: :bad_request, json: { errors: "Sorry we do not currently carry #{params[:title]}"}

    elsif movie.available_inventory > 0

      rental = Rental.new(rental_params)
      rental.movie_id = movie.id
      rental.check_out = DateTime.now

      if rental.save
        render status: :ok,  json: {
          id: rental.id,
          due_date: rental.due_date
        }
      else
        render status: :bad_request, json: {errors: rental.errors.messages}
      end

    else
      render status: :bad_request, json: {errors: "Sorry, #{params[:title]} is not available at this moment" }
    end
  end

  def check_in
    movie = Movie.find_by_title(params[:title])
    if !movie
      render status: :bad_request, json: { errors: "Sorry we do not currently carry #{params[:title]}"}
    else
      rentals = Rental.checked_out_by_customer(params[:rental][:customer_id])
      rental = rentals.find_by(movie_id: movie.id)

      if rental
        rental.check_in = DateTime.now
        rental.save
        render status: :ok, json: {
          id: rental.id,
          check_in: rental.check_in
        }
      else
        render status: :bad_request, json: { errors: "This customer does not have this movie checked out." }
      end
    end
    #  params[:customer_id]
    #
    # movie = Movie.find_by_title(params[:title])


    #update rental model check_in column

    #find rental where customer_id = params and movie = movies
  end

  def overdue

    rentals = []
    Rental.overdue.each do |rental|

      rentals << { title: rental.movie.title,
      customer_id:rental.customer_id,
      name: rental.customer.name,
      postal_code: rental.customer.postal_code,
      due_date: rental.due_date }

    end 

    render status: :ok,  json: rentals.as_json

  end

  private
  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end
end
