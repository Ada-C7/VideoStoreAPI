class MoviesController < ApplicationController

  before_action :find_movie, :only => [:show]

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :release_date]), status: :ok
  end

  def show
    if movie.nil?
      render json: { nothing: true }, status: :not_found
    else
      render json: movie.as_json(except: [:id, :updated_at, :created_at],
      methods: :available_inventory), status: :ok
    end
  end
end

private

def find_movie
  movie = Movie.find_by(title: params[:title])
  return movie
end
