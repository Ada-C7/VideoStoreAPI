class CustomersController < ApplicationController
  def index
    customers = Customer.all.as_json(
      only: [:id, :name, :registered_at, :postal_code, :phone],
      methods: :movies_checked_out_count
    )
    
    render json: customers, status: :ok
  end

end
