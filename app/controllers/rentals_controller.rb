require 'pry-rails'


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
    rental = Rental.new
    rental.duedate = params["rental"]["future_due_date"]
    rental.customer_id = params["rental"]["customer_id"]
    movie = Movie.find_by_title(params[:title])
    if movie
      rental.movie = movie
    else
      return render json: { errors: "Movie not found" }, status: :bad_request
    end

    # binding.pry
    rental.movie.available_inventory -= 1

    if rental.movie.save
      if rental.save
        render json: {id: rental.id}, status: :ok
      else
        render json: { errors: rental.errors.messages }, status: :bad_request
      end
    else
      render json: { errors: rental.movie.errors.messages }, status: :bad_request
    end
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



  # def rental_params
  #     params.require(:rental).permit(:future_due_date, :customer_id)
  # end
end
