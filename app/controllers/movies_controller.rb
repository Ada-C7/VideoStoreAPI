class MoviesController < ApplicationController
    def index
        @movies = Movie.all
        render json: @movies.as_json(only: [:id, :title, :release_date]), status: :ok
    end

    def show
        @movie = Movie.find_by(title: params[:title])

        if @movie.nil?
            render json: {}, status: :not_found
        else
            render json: @movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
        end
    end
end
