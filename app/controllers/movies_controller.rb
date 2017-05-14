class MoviesController < ApplicationController
  #List all the movies
  def index
    @movies = Movie.all

    unless @movies.count == 0
      render :json => @movies, status: :ok
    else
      render :json => @movies, status: :no_content
    end
  end

  def show
    @movie = Movie.find_by(title: params[:title])

    if @movie
      render :json => @movie, status: :ok, more_info: :true
    else
      render :json => @movie, status: :no_content
    end
  end
end
