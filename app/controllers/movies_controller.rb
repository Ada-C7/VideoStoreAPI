class MoviesController < ApplicationController
  # def zomg
  #   render :json => {message: "it works!"}, status: :ok
  # end
  def index
      movies = Movie.all
      render :json => movies.to_json, :callback => params['callback'],
        :status => :ok
    end

    def show
      movie = Movie.find(params[:title])

      render :json => movie.to_json, :callback => params['callback'],
        :status => :ok
    end


    def create
      movie = Movie.new(
        title: params[:title],
        overview: params[:overview],
        release_date:params[:release_date],
        inventory:
        params[:inventory]
      )

      if movie.save
        render :json => movie.to_json, :callback => params['callback'],
        :status => :ok
      else
        render :json => [], :callback => params['callback'], :status => :no_content
      end
    end
end
