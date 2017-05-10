class MoviesController < ApplicationController
  def zomg
    render json: "it works!"
  end

  def index
    movies = Movie.all
    if movies.length > 1
      render json: movies.as_json(only: [:title, :release_date]), status: :ok
    else
      render json: { no_movies: "Movies were not found" }, status: :not_found
    end
  end

  def show
    movie = Movie.find_by(title: params[:title])

    if movie
      render json:movie.as_json(except: [:created_at,:updated_at]),status: :ok
    else
      render json: {errors: {title: ["Movie '#{params[:title]}' not found"]} }, status: :not_found
    end
  end
end
