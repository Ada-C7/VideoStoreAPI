class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: ["release_date", "title"]), status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])

    if movie
      render json: movie.as_json(only: ["inventory", "overview", "release_date", "title"]), status: :ok
    else
      render json: { errors: errors[] }, status: :not_found
    end
  end
end
