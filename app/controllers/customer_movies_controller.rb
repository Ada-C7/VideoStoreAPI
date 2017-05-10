class CustomerMoviesController < ApplicationController

  def checkout
    @rental = CustomerMovie.new
    @rental.check_out(strong_params)
  end

  private

  def strong_params
    params.require(:customermovie).permit(:customer_id, :due_date, :title)
  end
end
