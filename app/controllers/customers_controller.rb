class CustomersController < ApplicationController
  def index
    customers = Customer.all

    if customers != []
      render json: customers, status: :ok
    else
      render json: {errors: "There are No Customers"}, status: :not_found
    end

  end

  def overdue
    rentals = Rental.where(returned_date: nil)
    overdue_rentals = []
    rentals.each do |rental|
      overdue_rentals << rental if rental.due_date < Time.now
    end

    customers = []
    if overdue_rentals.nil?
      render json: {errors: "No Overdue Rentals"}, status: :not_found
    else
      overdue_rentals.each do |overdue|
        customer = Customer.find_by(id: overdue.customer_id)
        unless customers.include?(customer)
          customers << customer
        end
      end
    end


    if customers == []
      render json: {errors: "No Customers with Overdue Movies"}, status: :not_found
    else
      render json: customers, status: :ok
    end
  end
end
