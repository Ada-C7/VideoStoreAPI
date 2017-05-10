class CustomerMovie < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def check_out(params)
    # Not working
    movie = Movie.find_by(title: params[:title])
    movie.available_inventory -= 1

    customer = Customer.find_by(id: params[:customer_id])
    customer.movie_checkout_count += 1
    # movie.checkout_date = Date.today
  end

end
