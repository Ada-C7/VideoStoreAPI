class ApplicationController < ActionController::API
  def zomg
    render json: "it works!"
  end
end
