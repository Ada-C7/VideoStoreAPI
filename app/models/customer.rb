class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals
  validates :name, presence: true
  validates :phone, presence: true


  def movies_checked_out_count
    count = 0
    self.rentals.each do |rental|
      if rental.returned_date.nil?
        count += 1
      end
    end
    return count
  end

  def overdue_date
    overdue = []
    if self.rentals != nil
      self.rentals.each do |rental|

        if rental.due_date < Time.now
          overdue << rental
          puts ">>>>>>>>"
          puts rental.due_date
          puts ">>>>>>>>"

        end
        # puts ">>>>>>>>"
        # puts overdue
        # puts ">>>>>>>>"
      end
    end
    if overdue != []
      puts overdue
      oldest = Time.now
      overdue.each do |over|
        if over.due_date < oldest
          oldest = over.due_date
        end
      end

      return oldest
    end

  end

end
