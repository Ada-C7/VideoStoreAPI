class RentalsController < ApplicationController


  def create
    movie = Movie.find_by_title(params[:title])

    if movie.nil? || movie.inventory < 1
      id = 0
    else
      id = movie.id
    end

    @rental = Rental.new(movie_id: id, customer_id: rental_params[:customer_id], due_date: rental_params[:due_date] )

    if @rental.save
      movie.inventory -= 1
      movie.save
      render status: :ok, json: @rental.as_json
    else
      render status: :error, json: { error: @rental.errors.full_messages }
    end
  end


  def update
    movie = find_movie(params[:title])
    customer = find_customer(params[:customer_id])
    if movie.nil?
      # if movie title not found
      render status: :bad_request, json: { error: "no movie found with that title"}
    elsif customer.nil?
      # if customer id not valid
      render status: :bad_request, json: { error: "no customer found"}
    else
      # find the rental in question based on params[:title] and params[:customer_id]
      rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
      # if found, set checkin_date to today's date
      if rental
        rental.checkin_date = Date.today
        rental.save
        render status: :ok, json: { nothing: true }
      else
        # if rental doesn't exist (customer id and movie id valid but movie never checked out)
        render status: :bad_request, json: { error: "that movie is not checked out to that customer"}
      end
    end
  end


    def overdue
      overdue_customers = Rental.over_due_rentals
      if overdue_customers.length == 0
        render json: { overdue: "none" }, status: :ok
      else
        render json: overdue_customers.as_json(only: [:title, :customer_id, :name, :postal_code, :checkout_date, :due_date], status: :ok)
      end
    end



  private

  def rental_params
    params.permit(:customer_id, :due_date)
  end


  def find_movie(title)
    Movie.find_by_title(title)
  end

  def find_customer(id)
    Customer.find_by_id(id)
  end

end
