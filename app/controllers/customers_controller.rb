class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render :json => customers, :status => :ok
  end
end
