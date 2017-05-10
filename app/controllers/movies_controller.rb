class MoviesController < ApplicationController
  #List all the movies
  def index
    movies = Movie.all

    unless movies.count == 0
      render :json => movies.as_json(only: [:title, :release_date]), status: :ok
    else
      render :jason, status: :no_content
    end
  end

  def show
    movie = Movie.find_by(title: params[:title])

    if movie
      render :json => movie, status: :ok
    else
      render :json => movie, status: :no_content
    end
  end
end
