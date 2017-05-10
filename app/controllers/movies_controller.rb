class MoviesController < ApplicationController
    def index
        movies = Movie.all
        render json: movies.as_json(only: [:title, :release_date]), status: :ok
    end

    def show
        movie = Movie.find_by_title(params[:title])
        if movie
            render json: movie.as_json(except: [:updated_at, :created_at]), status: :ok
        else
            render json: {}, status: :not_found
        end
    end
end
