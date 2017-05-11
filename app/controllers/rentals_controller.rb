class RentalsController < ApplicationController

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

  private

  def find_movie(title)
    Movie.find_by_title(title)
  end

  def find_customer(id)
    Customer.find_by_id(id)
  end
end
