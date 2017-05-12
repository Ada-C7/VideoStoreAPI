class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render :json => movies, :status => :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render :json => movie, status: :ok
    else
      render status: :not_found, json: {errors: "#{params[:title]} not found in the database."}
    end
  end

  def checkout
    
  end

  # def zomg
  #   render :json => "it works"
  # end
end
