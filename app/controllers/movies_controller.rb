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


  private
  def movie_params
    params.require(:movie).permit(:name, :age, :human)
  end
end
