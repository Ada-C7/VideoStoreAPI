class MoviesController < ApplicationController
  def checkout
    movie = Movie.find_by(title: params[:title].capitalize)
    due_date = Time.now + 3.days
    rental = Rental.create(customer_id: params[:customer_id], movie_id: movie.id, due_date: due_date)
    if rental
      render json: rental, status: :ok
    else
      render json: rental, status: :bad_request
    end
  end

  def checkin
    movie = Movie.find_by(title: params[:title].capitalize)

  end
end
