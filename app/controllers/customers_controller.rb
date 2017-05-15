class CustomersController < ApplicationController

  def index
    customers = Customer.all

    unless customers.count == 0
      render :json => customers, status: :ok
    else
      render json: { error: "List not found", status: 404 }, status: :not_found
    end
  end
end
