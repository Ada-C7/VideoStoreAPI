class MoviesController < ApplicationController

     def index
       movies = Movie.all
       render json: movies.as_json(only: [:title, :release_date]), status: :ok
     end

end
