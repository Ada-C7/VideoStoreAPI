class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :title, :overview, :release_date, :inventory]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie, status: :ok
    else
      render json: movie, status: :not_found
    end
  end
end
