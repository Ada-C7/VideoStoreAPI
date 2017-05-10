class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render json: movie.as_json(except: [:created_at, :updated_at, :id], methods: :available_inventory), status: :ok
    else
      render json: {title_match: false}, status: :not_found
    end
  end
end
