class ApplicationController < ActionController::API

    def index
        render json: {'message' =>"it works"}
    end
end     
