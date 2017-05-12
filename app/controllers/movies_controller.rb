class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies, each_serializer: MoviePreviewSerializer, status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title].capitalize)
    if movie
      render json: movie, status: :ok
    else
      render status: :not_found, json: { errors: { title: ["Movie '#{params[:title]}' not found"] } }
    end
  end
end
