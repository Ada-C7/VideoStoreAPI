class RentalsController < ApplicationController

  def create
    rental = Rental.new
    rental.movie = Movie.find_by title: params[:title]
    rental.customer = Customer.find(params[:rental][:customer_id])
    rental.due_date = params[:rental][:due_date]
    rental.save
    render status: :ok, json: { id: rental.id }
  end

end
