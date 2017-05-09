class CustomersController < ApplicationController
  def index
    customer = Customer.all
    render json: customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end
end
