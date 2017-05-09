class MoviesController < ApplicationController

  # def zomg
  #   render :json => { just_for_dan: "it works!" }, status: :ok
  # end

  def index
    movies = Movie.all

    if movies.length > 0
      render json: movies.as_json(only: [:title, :release_date]), status: :ok
    else
      render json: {error: "We have no movies at this time"}, status: 404
    end
  end

end
