class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def show
    movie = Movie.where(title: params[:title])

    if movie
      render json: movie, status: :ok 
      # serializer: DetailedMovieSerializer
    else
      render :json=>{ :errors =>movie.errors.full_messages },  status: :no_content
    end
  end
end
