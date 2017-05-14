class CustomersController < ApplicationController
  def index
    customers = Customer.all
    customers.map do |customer|
      customer.registered_at = customer.registered_at.to_time
      customer.save
    end

    sort_list = ["name", "registered_at", "postal_code"]
    if sort_list.include?(params[:sort])
      customers = customers.sort_by{|customer| customer[params[:sort]]}
    end
    if customers != []
      render json: customers, status: :ok
    else
      render json: {errors: "There are No Customers"}, status: :not_found
    end

  end

end





  # def overdue  <=== If you want to return the customer with multiple overdue movies once.
  #   rentals = Rental.where(returned_date: nil)
  #   overdue_rentals = []
  #   rentals.each do |rental|
  #     overdue_rentals << rental if rental.due_date < Time.now
  #   end
  #
  #   customers = []
  #   if overdue_rentals.nil?
  #     render json: {errors: "No Overdue Rentals"}, status: :not_found
  #   else
  #     overdue_rentals.each do |overdue|
  #       customer = Customer.find_by(id: overdue.customer_id)
  #       unless customers.include?(customer)
  #         customers << customer
  #       end
  #     end
  #   end
  #
  #   if customers == []
  #     render json: {errors: "No Customers with Overdue Movies"}, status: :not_found
  #   else
  #     sort_list = ["overdue_title", "name", "checkout_date", "due_date"]
  #     if sort_list.include?(params[:sort])
  #       customers = customers.sort_by{|customer| customer[params[:sort]]}
  #     end
  #     render json: customers, status: :ok, each_serializer: OverdueSerializer
  #   end
  # end
