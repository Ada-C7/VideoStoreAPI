class ApplicationController < ActionController::API
  def index
    render :json => { testing: "it works!!"}
  end
end
