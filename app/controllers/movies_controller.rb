class MoviesController < ApplicationController
  def index
    render :json => { message: "it works!"}
  end
end
