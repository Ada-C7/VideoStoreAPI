class CustomersController < ApplicationController
  def index
    @customers = Customer.all
    if @customers.empty?
      render json: { error: "No customers found" }, status: :not_found
    else
      render json: @customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
    end
  end
  def overdue
    rentals = Rental.where("due_date <= ?", Time.now)
    render :json => rentals, status: :ok
  end
end
