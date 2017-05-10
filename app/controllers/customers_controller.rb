class CustomersController < ApplicationController

  def index
    customers = Customer.all
    if customers.empty?
      render status: :internal_server_error, json: { errors: "Something went horribly wrong with our database. Sorry for inconvenience" }
    else
      render json: customers, status: :ok
    end
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer == nil
      render status: :not_found, json: { errors: "Cannot find a customer with id #{params[:id]}" }
    else
      render json: customer, status: :ok
    end
  end


end
