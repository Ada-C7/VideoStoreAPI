class MoviesController < ApplicationController

  def index
    movies = Movie.all
    if movies.empty?
      # render :json => [], status: :ok
      render :json => { "message" => "We have no customers :("},status: :ok
      # render :text => "404 No Content", status: :not_found
    else
      render :json => movies.as_json(only: [:title, :release_date]), status: :ok
    end
  end

  def show
    movie = Movie.find_by(slug: params[:title].parameterize)
    if movie.nil?
      render :json => "404 Not found", status: :not_found
    else
      # render :json => movie.as_json(only: [:available_inventory, :inventory, :overview, :release_date, :title]), status: :ok
      render :json => movie, status: :ok
    end
  end

  # private
  #   def movie_params
  #     params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  #   end
end
