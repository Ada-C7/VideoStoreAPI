class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def show
    movie = Movie.where(title: params[:title])

    if movie.empty?
      error = "Movie '#{params[:title]}' not found"
      render json: { errors: {title: "Movie '#{params[:title]}'' not found"}}.to_json, status: :not_found
    else
      render json: movie, status: :ok, each_serializer: DetailedMovieSerializer
    end
  end
end
