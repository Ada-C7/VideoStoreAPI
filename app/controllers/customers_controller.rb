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
    puts ">>>>>>>>>>>>>"
    puts overdue_rentals
    puts ">>>>>>>>>>>>>"

    customers = []
    overdue_rentals.each do |overdue|
      customers << Customer.find_by(id: overdue.customer_id)
    end
    puts ">>>>>>>>>>>>>"
    puts customers
    puts ">>>>>>>>>>>>>"


    if customers.nil?
      render json: customers, status: :not_found
    else
      render json: customers, status: :ok
    end
  end
end
