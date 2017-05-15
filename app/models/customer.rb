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


  # def overdue_date
    # self.rentals.where("due_date < ?", Time.now)
    #             .order(due_date: :asc)
    #             .first.due_date
  # end
  def number_of_overdues
    current_rentals = self.rentals.where(returned_date: nil)
    rentals = current_rentals.where("due_date < ?", Time.now)
    return rentals.count
  end


#======== below : for returning a customer with mutiple overdue movies once in the overdue list
  # def number_of_overdues
  #   due_date.count if due_date != nil
  # end
  #
  # def overdue_map
  #   rentals = self.rentals.where("due_date < ?", Time.now)
  #               .order(due_date: :asc)
  #
  #   results = rentals.map do |rental|
  #     yield(rental)
  #   end
  #
  #   return rentals.empty? ? nil : results
  # end
  #
  # def checkout_date
  #   overdue_map do |rental|
  #     rental.created_at
  #   end
  # end
  #
  # def due_date
  #   overdue_map do |rental|
  #     rental.due_date.to_time
  #   end
  #
  #   # overdue = []
  #   # if self.rentals != nil
  #   #   self.rentals.each do |rental|
  #   #
  #   #     if rental.due_date < Time.now
  #   #       overdue << rental
  #   #     end
  #   #
  #   #   end
  #   # end
  #   # if overdue != []
  #   #   oldest = Time.now
  #   #   overdue.each do |over|
  #   #     if over.due_date < oldest
  #   #       oldest = over.due_date
  #   #     end
  #   #   end
  #   #
  #   #   return oldest
  #   # end
  #
  # end
  #

  #
  # def overdue_title
  #   overdue_map do |rental|
  #     rental.movie.title
  #   end
  # end

end
