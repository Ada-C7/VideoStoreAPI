class MoviesController < ApplicationController

  def index
    movies = Movie.all
    if movies.empty?
      render :text => "204 No Content", status: :no_content
    else
      render :json => movies.as_json(only: [:title, :release_date]), status: :ok
    end
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie.nil?
      render :text => "204 No content", status: :no_content
    else
      render :json => movie.as_json(only: [:available_inventory, :inventory, :overview, :release_date, :title]), status: :ok
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :overview, :release_date, :inventory)
    end
end
