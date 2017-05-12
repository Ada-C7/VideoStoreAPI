class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: #only - this is the safe list for return keys
    movies.as_json(only: [:title, :release_date, :overview, :inventory])
  end

  def show
    #movies = Movie.find_by(:id params[:id])
    movie = Movie.find_by(title: params[:title])
    if movie #except - this is a block list, block these items
      render json: movie.as_json(except: [:id, :updated_at, :created_at],
      ), status: :ok #in parens (after created at) add any special methods like `methods: :calculate_age`

    else #return this status hash so the other machine doesn't send freak out
      
      render status: :not_found, json: { errors: { title: "#{params[:title]} not found" } }
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
    params.require(:movie).permit(:id, :title, :release_date, :overview, :inventory)
  end
end
