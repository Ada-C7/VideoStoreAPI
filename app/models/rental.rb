class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true
  validate :valid_due_date
  validate :check_inventory

  def initialize rental_params
    converted_date = convert_date(rental_params[:due_date])
    rental_params[:due_date] = converted_date
    movie =  Movie.find_by(title: rental_params[:title])
    if movie
      rental_params[:movie_id] = movie.id
    end
    rental_params.delete(:title)
    super(rental_params)
  end

  def check_inventory
    if movie
      if movie.available_inventory <= 0
        errors.add(:availability, "Sorry, this movie is out of stock")
      end
    end
  end

  def convert_date date
    if date =~ /\A\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\z/
      return Date.parse(date)
    else
      date
    end
  end

  def valid_due_date
    if due_date.class != Date
      errors.add(:due_date, "date must be in YYYY-MM-DD format")
    elsif due_date <= Date.current
      errors.add(:due_date, "due date must be after today")
    end
  end


end
