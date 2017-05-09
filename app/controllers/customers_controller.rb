class CustomersController < ApplicationController

  def index
    customers = Customer.all
    if customers.empty?
      render status: :not_found, json: { errors: "Cannot find customers" }
    else
      render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
    end
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer == nil
      render status: :not_found, json: { errors: "Cannot find a customer with id #{params[:id]}" }
    else
      render json: customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
    end
  end


end
