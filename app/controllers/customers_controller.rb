class CustomersController < ApplicationController

  def index
    render :json => { silly_message: "it works!" }
  end
end
