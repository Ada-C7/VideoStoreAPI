class CustomersController < ApplicationController

  def index
    customers = Customer.all
    if customers == []
      render json: customers, status: :ok
    else
      render json: customers, status: :ok
    end

  end


end # END of class CustomersController
