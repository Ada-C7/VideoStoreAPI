class RentalsController < ApplicationController
  def index
    overdue_customers = overdueCustomersRentals
    final_product = []
    overdue_customers.each do |customer,rentals|
      cust = {}
      cust["customer_id"] = customer.id
      cust["name"] = customer.name
      cust["postal_code"] = customer.postal_code
      formatted_rentals = []
      rentals.each do |rental|
        rent = {}
        rent["checkout_date"] = rental.created_at
        rent["due_date"] = rental.duedate
        rent["title"] = rental.movie.title
        formatted_rentals << rent
      end
      cust["rentals"] = formatted_rentals
      final_product << cust
    end

    render json: final_product.as_json, status: :ok
  end

  def create
    # must be given title, customer_id, duedate
    # returns confirmation
    # returned is false (default)
    # set the duedate
    # updates movies available inventory
  end

  def update
    # must be give customer_id, title
    # returns confirmation
    # changes returned to true
    # updates movie's available inventory
  end

  private

  def overdueCustomersRentals
    overdue_rentals = Rental.list_of_overdue
    return overdue_rentals.group_by { |overdue_rental| overdue_rental.customer }
  end
end
