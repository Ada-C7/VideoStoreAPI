class CustomersController < ApplicationController
    def index
        customers = Customer.all
        render json: customers.as_json(except: [:created_at, :updated_at], methods: :movies_checked_out_count), status: :ok
    end
end
