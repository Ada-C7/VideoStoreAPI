class MoviesController < ApplicationController
  def zomg
    render json: {hungry: "It works"}
  end

  def index
    movies = Movie.all
    render json: movies.as_json(except: [:created_at, :updated_at, :id]), status: :ok
  end
end
