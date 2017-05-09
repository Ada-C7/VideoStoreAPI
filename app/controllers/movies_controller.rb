class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: ["release_date", "title"]), status: :ok
  end

  def show
  end
end
