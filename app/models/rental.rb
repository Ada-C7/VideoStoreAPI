class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def self.overdue
    Rental.where("due_date < ?", Date.today).checkedout
  end

  def self.checkedout
    Rental.where(:checkin_date => nil)
  end
end
