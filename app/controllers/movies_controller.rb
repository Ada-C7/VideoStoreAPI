class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: ["release_date", "title"]), status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])

    if movie
      render json: movie.as_json(only: ["available_inventory", "inventory", "overview", "release_date", "title"],
      methods: :available_inventory
      ), status: :ok
    else
      render json: { errors: { title: "Movie '#{params[:title]}' not found." } }, status: :not_found
    end
  end
end
