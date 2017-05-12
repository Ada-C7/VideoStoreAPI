require 'date'
class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :check_out_date, presence: true
  validates :due_date, presence: true
  validates :status, inclusion: { in: [ "checked out", "checked in", "overdue" ] }
  validate :movie_id, :check_inventory
  # this validation also ran on overdue_movies - not just controller update
  # validates :return_date, presence: true, on: :update



  def self.create_rental(info)
    rental = Rental.new
    rental.movie_id = info[:movie_id]
    rental.customer_id = info[:customer_id]
    rental.check_out_date = Date.today
    rental.due_date = Date.today + 3
    rental.status = "checked out"
    rental.movie.decrease_inventory
    rental.customer.increase_checkout_count
    rental.valid?
    return rental
  end

  def self.overdue_movies
    array_of_overdues = []
    Rental.all.each do |rental|
      next if rental.due_date == nil
      if rental.due_date < Date.today
        rental.status = "overdue"
        rental.save
        array_of_overdues << rental
      end
    end
    return array_of_overdues
  end

  def check_inventory
    movie = self.movie
    if movie.nil? || movie.available_inventory == 0 || movie.available_inventory.nil?
      errors.add(:movie_id, "no available inventory")
    end
  end


end
