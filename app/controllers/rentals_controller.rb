class RentalsController < ApplicationController
  def checkout
    rental = Rental.new
    rental.movie_id = Movie.find_by(title: params[:title].capitalize).id
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7.days
    rental.customer_id = Costumer.find_by(name: params[:name].capitalize)
  end
end
