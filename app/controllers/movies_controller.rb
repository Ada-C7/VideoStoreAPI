class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: #only - this is the safe list for return keys
    movies.as_json(only: [:id, :title, :release_date, :overview, :inventory])
  end

  def show
    #movies = Movie.find_by(:id params[:id])
    movie = Movie.find_by_id(params[:id])
    if movie #except - this is a block list, block these items
      render json: movie.as_json(except: [:updated_at, :created_at],
      ), status: :ok #in parens (after created at) add any special methods like `methods: :calculate_age`

    else #return this status hash so the other machine doesn't send freak out
      render json: { nothing: true },
      status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    if
      movie.save
      render status: :ok, json: {id: movie.id}
    else
      render status: :bad_request, json: { errors: movie.errors.messages }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :overview)
  end
end
