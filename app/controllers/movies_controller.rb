class MoviesController < ApplicationController

  def index
    movies = Movie.all
    if movies.empty?
      render :json => [], status: :ok
    else
      render :json => movies.as_json(only: [:title, :release_date]), status: :ok
    end
  end

  def show
    movie = Movie.find_by(slug: params[:title].parameterize)
    if movie.nil?
      render json: {"errors": { "title": ["Movie '#{params[:title]}' not found"] } }, status: :not_found
    else
      render :json => movie, status: :ok
    end
  end
end
