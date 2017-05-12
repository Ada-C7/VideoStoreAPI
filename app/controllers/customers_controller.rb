class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: ["id", "movies_checked_out", "name", "phone", "postal_code", "registered_at"],
    methods: :movies_checked_out_count
    ), status: :ok
  end
end
