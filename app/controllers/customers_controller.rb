class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers.empty?
      render :json => [], status: :ok
      # zomg rendering works yaya!
      # render :text => "IT WORKS!", status: :ok
    else
      render :json => customers , status: :ok
    end
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render :json => customer, status: :ok
    else
      render :json => customer, status: :not_found
    end
  end
end
