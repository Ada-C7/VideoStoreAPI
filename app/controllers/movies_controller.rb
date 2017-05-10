class MoviesController < ApplicationController

  # def zomg
  #   render :json => { just_for_dan: "it works!" }, status: :ok
  # end

  def index
    movies = Movie.all

    if movies.length > 0
      render json: movies.as_json(only: [:title, :release_date]), status: :ok
    else
      render json: {error: "We have no movies at this time"}, status: 404
    end
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
      # add available _inventory
    else
      #render :not_found = 404
      render status: :not_found, json: { error: "Could not find a movie with the title #{params[:title]}"}
    end
  end

end
