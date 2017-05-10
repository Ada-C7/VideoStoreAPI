class CustomersController < ApplicationController
  def index
    customers = Customer.all

    if customers != []
      render json: customers, status: :ok
    else
      render json: customers, status: :not_found
    end

  end

  def overdue
  end
end
