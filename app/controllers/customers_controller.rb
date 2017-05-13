class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at, :account_credit, :movies_checked_out_count])
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render status: :ok, json: { id: customer.id}
    else
      render status: :bad_request, json: { errors: customer.errors.messages }
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :address, :city, :state, :postal_code, :phone, :registered_at, :account_credit, :movies_checked_out_count)
  end
end
