class Rental < ApplicationRecord
    belongs_to :customer
    belongs_to :movie

    validates :checkout_date, presence: true
    validates :due_date, if: :checkout_date, presence: true
    validate :valid_due_date?, if: [ :due_date, :checkout_date ]

    def valid_due_date?
      checkout_day = Date.strptime(checkout_date, "%Y-%m-%d")
      due_day = Date.strptime(due_date, "%Y-%m-%d")
      if due_day == checkout_day + 7
        return true
      else
        errors.add(:due_date, "must be 7 days from checkout_date")
        return false
      end
    end

    def title
      movie.title
    end

    def name
      customer.name
    end

    def postal_code
      customer.postal_code
    end

    def self.overdue
      Rental.all.each do |rental|
        return rental if rental.due_date.past?
      end
    end
end
