class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      movie_json = movie.as_json(
      only: [:title, :overview, :release_date, :inventory]
      )
      movie_json["available_inventory"] = movie.available_inventory

      render json: movie_json, status: :ok
    else
      render json: { nothing: true }, status: :not_found
    end
  end
end
