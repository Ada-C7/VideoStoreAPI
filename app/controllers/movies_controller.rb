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

end
