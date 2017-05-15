class CustomerMoviesController < ApplicationController

  # def initialize(params)
  #   rental[params]
  # end

  def checkout
    @rental = CustomerMovie.new
    @rental.checkout_date =
    # rental.customer = Customer.find_by(id: params[:customer_id])
    @rental.check_out(strong_params, params[:title])#(strong_params)
    # rental.check_out(strong_params)
    # rental.movie_id = Movie.find_by(title: params[:title]).id
    # rental.customer_id = Customer.find_by(id: params[:customer_id]).id
    # rental.checkout_date = rental.check

  end

  private

  def strong_params
    params.require(:customer_movies).permit(:customer_id, :due_date)
  end
end
