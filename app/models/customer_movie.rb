class CustomerMovie < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def check_out(params, title)
    movie = Movie.find_by(title: title)#_by(title: params[:title])
    # movie.available_inventory

    customer = Customer.find_by(id: params[:customer_id])


    time_now = Time.now
    @rental[:checkout_date] = time_now.strftime("%Y-%m-%d") # => "2013-08-06"
    # next_date = time_now + (5*(60*60*24))
    # movie.due_date = next_date.strftime("%Y-%m-%d")
  end

private
  def movie_params
    params.require(:movies).permit(:title)
  end


end
