class MoviesController < ApplicationController
  def zomg
    render json: {hungry: "It works"}
  end
end
