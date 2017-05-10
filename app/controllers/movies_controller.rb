class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :release_date]), status: :ok
  end

  def show
    # this might be better if titles can be duplicate
    # returns an array of instances rather than an instance
    # movie = Movie.where({title: params[:title]})

    movie = Movie.find_by(title: params[:title])

    if movie
      render json: movie.as_json(except: [:id, :updated_at, :created_at],
      methods: :available_inventory), status: :ok
    end
  end
end
