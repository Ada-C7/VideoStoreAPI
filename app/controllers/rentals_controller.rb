class RentalsController < ApplicationController

  def update
    # movie_id = find_movie_id(params[:title])
    # find the rental in question based on params[:title] and params[:customer_id]
    customer_id = params[:customer_id]
    movie_id = Movie.find_by(title: params[:title])

    rental = Rental.find_by(customer_id: customer_id, movie_id: movie_id)
    # if found, set checkin_date to today's date
    if rental
      rental.checkin_date = Date.today
      rental.save
      render status: :ok, json: { nothing: true }
    end


    # if not found, do various things based on
    # if customer id not valid
    # if movie title not found
    # if rental doesn't exist (customer id and movie id valid but movie never checked out)
  end

  # def find_movie_id(title)
  #   Movie.find_by_title(title).id
  # end
end
