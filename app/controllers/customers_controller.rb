class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers.length > 1
      render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone]), status: :ok
    else
      render json: {no_customers: "Customers were not found"}, status: :not_found
    end
  end
end
