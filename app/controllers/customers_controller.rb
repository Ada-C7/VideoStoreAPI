class CustomersController < ApplicationController

  def index
    customers = Customer.all

    unless customers.count == 0
      render :json => customers, status: :ok
    else
      render :json, status: :no_content
    end
  end
end
