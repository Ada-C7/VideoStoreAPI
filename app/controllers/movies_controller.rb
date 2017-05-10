class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render :json => movies, status: :ok
  end
end
