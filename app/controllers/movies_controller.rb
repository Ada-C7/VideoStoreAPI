class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory])
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
    else
      render json:{ nothing: true }, status: :not_found
    end
  end


  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory
    if movie.save
      # movie.available_inventory = movie.inventory
      render status: :ok, json: {id: movie.id}
    else
      render status: :bad_request, json: {errors: movie.errors.messages}
    end
  end



  private


  def movie_params
    params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end
end
