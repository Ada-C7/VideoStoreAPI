class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers.length > 0
      render :json => customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone]), status: :ok
    else
      render :json => {no_customers: "There are no customers in the database"}, status: :not_found
    end
  end
end
