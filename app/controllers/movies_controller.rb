class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json(only: [:title, :release_date])
  end

  def show
    movie = Movie.find_by(title: params[:title])

    if movie
      render json: movie.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: {nothing: true}, status: :not_found
    end
  end

end
