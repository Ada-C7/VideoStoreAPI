class CustomersController < ApplicationController
  def index
    customers = Customer.all

    if customers != []
      render json: customers, status: :ok
    else
      render json: customers, status: :not_found
    end

  end

  def overdue
    rentals = Rental.where(returned_date: nil)
    overdue_rentals = []
    rentals.each do |rental|
      overdue_rentals << rental if rental.due_date < Time.now
    end
    customers = []
    overdue_rentals.each do |overdue|
      customers << Customer.find_by(id: overdue.customer_id)
    end

    if customers.nil?
      render json: customers, status: :not_found
    else
      render json: customers, status: :ok
    end
  end
end
