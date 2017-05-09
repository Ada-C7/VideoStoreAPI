class CustomersController < ApplicationController
  def index
    customers = Customer.all.as_json(
      only: [:id, :name, :registered_at, :postal_code, :phone]
    ).each { |customer|
      customer["movies_checked_out_count"] = Customer.find_by_id(customer["id"]).movies_checked_out_count
    }

    render json: customers, status: :ok
  end

end
