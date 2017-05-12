class CustomersController < ApplicationController
  def index
    if Customer.all.length > 0
      if params[:sort] == "name" || params[:sort] == "registered_at" || params[:sort] == "postal_code"
        sorted_customers = Customer.order(params[:sort].to_sym)
        render :json => sorted_customers, status: :ok
      else
        render :json => Customer.all, status: :ok
      end
    else
      render :json => {no_customers: "There are no customers in the database"}, status: :not_found
    end
  end
end
