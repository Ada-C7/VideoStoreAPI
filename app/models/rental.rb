class Rental < ApplicationRecord
    belongs_to :customer
    belongs_to :movie

    validates :checkout_date, presence: true
    validates :due_date, if: :checkout_date, presence: true
    validate :valid_due_date?, if: [ :due_date, :checkout_date ]

    def valid_due_date?
      checkout_day = Date._parse(checkout_date)[:mday]
      due_day = Date._parse(due_date)[:mday]
      if due_day == checkout_day + 7
        return true
      else
        errors.add(:due_date, "must be 7 days from checkout_date")
        return false
      end
    end
end
