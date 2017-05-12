class CustomersController < ApplicationController

  def index
    customers = Customer.all
    if customers.length > 0
      if params[:sort] == "name" || params[:sort] == "registered_at" || params[:sort] == "postal_code"

        customers = customers.order(params[:sort].to_sym)
      end
      if (params[:n] && params[:p])
        #Assuming a pagination request comes with BOTH a value for p and n
        customers = customers.paginate(:page => params[:p], :per_page => params[:n])
      end
      render :json => customers, status: :ok
    else
      render :json => {no_customers: "There are no customers in the database"}, status: :not_found
    end
  end
  
end
