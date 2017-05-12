class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
  end
  def overdue
    rentals = Rental.where('due_date <= ?', Time.now)
    if rentals.empty?
      render 'plain text' => "There are no customers with overdue items", status: :no_content
    else
      render :json => rentals, status: :ok
    end
  end
end
