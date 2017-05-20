class MoviesController < ApplicationController

     def index
          movies = Movie.all
          render json: movies.as_json(only: [:title, :release_date]), status: :ok
     end

     def show
          movie = Movie.find_by(title: params[:title])

          if movie
               render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
          else
               render json: { errors:  { title: "#{params[:title]} was not found." } }, status: :not_found
          end
     end

     private

     def movie_params
          params.require(:movie).permit(:title, :overview, :release_date, :inventory, :available_inventory)
     end

end
