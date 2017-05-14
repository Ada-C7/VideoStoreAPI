class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true

  has_many :customers, through: :customer_movie
  has_many :customer_movies

  def check_out(title_params)
    # movie = Movie.find_by(title: params[:title])
    # movie.available_inventory
  end

  def available_inventory
    # rentals = CustomerMovie.all
    # quantity = rentals.where(id: params[:movie_id]).count
    # a_i = inventory - quantity
  end

  def checkedoutmovies

  end

end
