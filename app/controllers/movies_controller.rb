class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only:
    [:title, :release_date ]), :status => :ok
  end

  def show
    movie = Movie.find_by title: params[:title]
    if movie
      movie.available_inventory = movie.inventory - movie.rentals.length
      render json: movie.as_json(only:
      [:title, :release_date, :overview, :inventory, :available_inventory]), :status => :ok
    else
      render status: :not_found, json: { error: "#{params[:title]} not found"}
    end
  end

end
