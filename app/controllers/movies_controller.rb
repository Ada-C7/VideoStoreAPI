class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])

    if movie
      render json: movie.as_json(only: [:id, :name, :age, :human]), status: :ok
    else
      render json: movie,  status: :no_content
    end
  end

  def create
    movie = movie.new(movie_params)
    movie.save!
    render status: :ok, json: { id: movie.id }
  end
  private
  def movie_params
    params.require(:movie).permit(:name, :age, :human)
  end
end
