class MoviesController < ApplicationController
  # def zomg
  #   render :json => {message: "it works!"}, status: :ok
  # end
  def index
    movies = Movie.all
    render :json => movies.as_json(only:[:id, :title, :overview, :release_date, :inventory], methods: :available_inventory), :status => :ok
  end

  def show
    @movie = Movie.find_by(title: params[:title])
    if @movie == {}
      render :json=> @movie.as_json(only:[:id, :title, :overview, :release_date, :inventory], methods: :available_inventory), :status => :ok
    else
      render :json=> @movie.as_json, status: :not_found
    end
  end


  def create

    @movie = Movie.new(
    title: params[:movie][:title],
    overview: params[:movie][:overview],
    release_date:params[:movie][:release_date],
    inventory:
    params[:movie][:inventory]
    )

    if @movie.save
      render :json => @movie.to_json,  :status => :ok
    else
      render :json => {errors: @movie.errors.messages}, :status => :bad_request

    end
  end




end
