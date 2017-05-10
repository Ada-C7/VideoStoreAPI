class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(except: [:created_at, :updated_at, :id]), status: :ok
  end

  def show
    movie = Movie.find_by_title(params[:title])

    if movie
      render json: movie.as_json(except: [:created_at, :updated_at, :id]), status: :ok
    else
      render json: {errors: {"title": ["Movie '#{params[:title]}' not found"]} }, status: :not_found
    end

  end
end
