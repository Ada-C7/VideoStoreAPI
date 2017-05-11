class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def show
    movie = Movie.where(title: params[:title])

    if movie.empty?
      error = "Movie '#{params[:title]}' not found"
      render json: { errors: {title: "Movie '#{params[:title]}'' not found"}}.to_json, status: :not_found
    else
      render json: movie, status: :ok, each_serializer: DetailedMovieSerializer
    end
  end

  def checkin
    movie = Movie.find_by(title: params[:title].capitalize)
    rental = Rental.find_by(movie_id: movie.id, customer_id: params[:customer_id])
    if rental
      rental.returned_date = Time.now
      rental.save
      render json: rental, status: :ok
    else
      render json: rental, status: :not_found
    end
  end


  private
  def movie_params
    params.require(:movie).permit(:name, :age, :human)
  end

end
