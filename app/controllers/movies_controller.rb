class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])

    if movie
      render json: movie, status: :ok, serializer: DetailedMovieSerializer
    else
      render json: movie,  status: :no_content
    end
  end

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
    # movie = Movie.find_by(title: params[:title].capitalize)
    rental = Rental.find_by(movie_id: movie.id, customer_id: params[:customer_id])
    if rental
      rental.returned_date = Time.now
      render json: rental, status: ok
    else
      render json: rental, status: :not_found
    end
  end


  private
  def movie_params
    params.require(:movie).permit(:name, :age, :human)
  end
end
