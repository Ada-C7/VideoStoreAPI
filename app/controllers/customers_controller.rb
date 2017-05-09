class CustomersController < ApplicationController
def index
  # customers = Customer.all
    # if pets.empty?
      render :text => "IT WORKS!", status: :ok
    # else
      # render :json => pets.as_json(only: [:id, :name, :age, :human]), status: :ok
    # end

end

end
