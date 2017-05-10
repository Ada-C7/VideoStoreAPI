class MoviesController < ApplicationController

  def index
    movies = Movie.all
    if movies.empty?
      render :text => "204 No Content", status: :no_content
    else
      render :json => movies.as_json(only: [:title, :release_date]), status: :ok
    end
  end

  # def show
  # end

end
