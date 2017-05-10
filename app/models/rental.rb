class Rental < ApplicationRecord
  validates :check_out_date, presence: true
  validates :return_date, presence: true
  validates :due_date, presence: true
  validates :status , presence: true, inclusion: { in: [ "checked out", "checked in", "overdue"] }
end
