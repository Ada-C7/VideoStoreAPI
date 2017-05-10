class MoviesController < ApplicationController
  def index
    movies = Movie.all

    if movies.empty?
      render json: { errors: "Something is wrong with the database" },
      status: :internal_server_error
    else
      render json: movies.as_json(only: [:title, :release_date]), status: :ok
    end
  end

  def show
    movie = Movie.find_by( title: params[:title])
    if movie == nil
      render status: :not_found, json:{
        "errors": { "title": ["Movie #{params[:title]} not found"]  }
      }
    else
      render json: movie.as_json(only: [ :title, :overview, :release_date, :inventory, :available_inventory ]), status: :ok
    end

  end
end
