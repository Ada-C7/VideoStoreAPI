class MoviesController < ApplicationController
  def index
    movies = Movie.all

    if movies.empty?
      render json: { errors: "Something is wrong with the database"},
             status: :internal_server_error
    else
      render json: movies.as_json(only: [:title, :release_date]), status: :ok
    end
  end
end
