class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers.empty?
      render :text => "404 no content",status: :not_found
      # zomg rendering !
      # render :text => "IT WORKS!", status: :ok
    else
      render :json => customers , status: :ok
    end
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render :json => customer, status: :ok
    else
      render :json => customer, status: :no_content
    end
  end

  # def create
  #   customer = Customer.new(customer_params)
  #   customer.save!
  #   render status: :ok, json: { id: customer.id }
  # end

  private
  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :movies_checked_out_count)
  end
end
