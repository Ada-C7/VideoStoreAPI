require 'date'
class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :check_out_date, presence: true
  # validates :return_date, presence: true
  validates :due_date, presence: true
  validates :status , presence: true, inclusion: { in: [ "checked out", "checked in", "overdue"] }

# {"rental"=>{"customer_id"=>1, "date"=>"2017-05-10"}, "title"=>"Psycho"}
 # {customer_id => 1, movie_id => #}
  def self.create_rental(info)
    rental = Rental.new
    # find_movie ? bad design to call Movie.find_by in Rental class
    # movie = Movie.find_by(title: info["title"])
    rental.movie_id = info[:movie_id]
    rental.customer_id = info[:customer_id]
    rental.check_out_date = Date.today
    rental.due_date = Date.today + 3
    rental.status = "checked out"
    return rental
  end


  def self.get_overdue
    array_of_overdue = []
    Rental.all.each do |rental|
      if #due_date before today
        rental.status = "overdue"
        rental.save
        array_of_overdue << rental
    end
  end
  return array_of_overdue
  end





end
