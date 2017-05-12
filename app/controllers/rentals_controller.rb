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

    #  params[:customer_id]
    #
    # movie = Movie.find_by_title(params[:title])


    #update rental model check_in column

    #find rental where customer_id = params and movie = movies
  end

  def overdue
  end

  private
  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end
end
