class MoviesController < ApplicationController
  def index
    movies = Movie.all

    if movies.empty?
      render json: { errors: "Something is wrong with the database" },
      status: :internal_server_error
    else
      render json: movies, each_serializer: MovieListSerializer, status: :ok
    end
  end

  def show
    movie = Movie.find_by( title: params[:title])
    if movie == nil
      render status: :not_found, json:{
        "404 error": { "title": ["Movie #{params[:title]} not found"]  }
                                      }
    else
      render json: movie, status: :ok
    end
  end
end
