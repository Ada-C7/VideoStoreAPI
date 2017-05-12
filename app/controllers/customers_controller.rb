class CustomersController < ApplicationController

  def index
    customers = Customer.all
    if params[:sort] == "name"
      customers.sort_by {|customer| customer.name}
      render json: customers.as_json(except: [:created_at, :updated_at]), status: :ok
    end
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: customer.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: {errors: {
        customer: ["Customer with id #{params[:id]} not found"] }}, status: :not_found
    end
  end

end
