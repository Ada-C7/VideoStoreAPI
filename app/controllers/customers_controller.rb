class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit]), status: :ok
  end

  # def show
  #   customer = Customer.find_by(id: params[:id])
  #   if customer
  #     render json: customer, status: :ok
  #   else
  #     render json: customer, status: :not_found
  #   end
  # end
end
