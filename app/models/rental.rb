class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true
  validate :valid_due_date

  def initialize rental_params
    converted_date = convert_date(rental_params[:due_date])
    rental_params[:due_date] = converted_date
    super(rental_params)
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
