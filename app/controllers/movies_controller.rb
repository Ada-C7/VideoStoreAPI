class MoviesController < ApplicationController
  def zomg
    render :json => {message: "it works!"}, status: :ok
  end



  def show
    @movie = Movie.find_by(title: params[:title])
    if @movie
    render :json=> @movie.as_json(only: [:title, :release_date,:overview, :inventory]), status: :ok
    else
      render :json=>@movie.as_json, status: :not_found
    end

  end
end
