class CustomersController < ApplicationController

  def index
    customers = Customer.all
    if customers == [] || customers
      render json: customers, status: :ok
    else
      render json: customers, status: :bad_request
    end

  end


end # END of class CustomersController
