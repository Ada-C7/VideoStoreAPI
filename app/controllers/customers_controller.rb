class CustomersController < ApplicationController
    def index
        customers = Customer.all
        render json: customers.as_json(except: [:created_at, :updated_at], methods: :checked_out_movies), status: :ok
    end
end
