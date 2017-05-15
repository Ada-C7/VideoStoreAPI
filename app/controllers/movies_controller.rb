class MoviesController < ApplicationController
  #List all the movies
  def index
    @movies = Movie.all

    unless @movies.count == 0
      render :json => @movies, status: :ok
    else
      render :json => {errors: {title: "List not found", status: "Not found"}}, status: :not_found
    end
  end

  def show
    @movie = Movie.find_by(title: params[:title])

    if @movie
      render :json => @movie, status: :ok, more_info: :true
    else
      render :json => {errors: {title: "Movie '#{params[:title]}' not found", status: "Not found"}}, status: :not_found
      end
    end
  end
