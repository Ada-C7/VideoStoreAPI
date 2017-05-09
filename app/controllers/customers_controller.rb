class CustomersController < ApplicationController
  def index
    movies = Customer.all
    render json: movies.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end


end
