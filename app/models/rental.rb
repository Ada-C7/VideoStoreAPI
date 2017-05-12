require 'date'
class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :check_out_date, presence: true
  validates :due_date, presence: true
  validates :status , presence: true, inclusion: { in: [ "checked out", "checked in", "overdue" ] }
  validates :return_date, presence: true, on: :update


  # {"rental"=>{"customer_id"=>1, "date"=>"2017-05-10"}, "title"=>"Psycho"}
  # {customer_id => 1, movie_id => #}
  def self.create_rental(info)
    rental = Rental.new
    rental.movie_id = info[:movie_id]
    rental.customer_id = info[:customer_id]
    rental.check_out_date = Date.today
    rental.due_date = Date.today + 3
    rental.status = "checked out"
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
end
