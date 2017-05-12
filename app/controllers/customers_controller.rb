class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render :json => customers, status: :ok
  end

  # No customer show per READ ME
  # def show
  #   customer = Customer.find_by(id: params[:id])
  #   if customer
  #     render json: customer, status: :ok
  #   else
  #     render json: customer, status: :not_found
  #   end
  # end
end
