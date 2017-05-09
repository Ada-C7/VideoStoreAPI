class MoviesController < ApplicationController
  def zomg
    render :json => {message: "it works!"}, status: :ok
  end
end
