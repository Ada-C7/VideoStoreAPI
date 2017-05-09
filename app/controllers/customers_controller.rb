class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: customers.as_json(except: [:created_at, :updated_at])
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: customer.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: {nothing: true}, status: :not_found
    end
  end

end
