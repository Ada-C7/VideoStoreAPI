class CustomersController < ApplicationController

  def index
    customers = Customer.all

    unless customers.count == 0
      render :json => customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checkout_out_count]), status: :ok
    else
      render :json, status: :no_content
    end
  end
end
