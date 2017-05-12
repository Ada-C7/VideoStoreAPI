class CustomersController < ApplicationController

  def index
    if ["name", "registered_at", "postal_code"].include?(params[:sort])
      customers = Customer.order(params[:sort])
    else
      customers = Customer.all
    end

    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone],
    methods: :movies_checked_out_count), status: :ok
  end
end
