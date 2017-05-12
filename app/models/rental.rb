class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  after_initialize :set_defaults

  validates :due_date, presence: true
  validate :due_date_not_in_past
  # validate :enough_inventory

  validates :customer_id, presence: true


  def due_date_not_in_past
    if due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  # def enough_inventory
  #   inventory = movie.inventory
  #   if inventory < 1
  #     errors.add(:inventory, "not enough inventory")
  #   end
  # end

  def set_defaults
    self.checkout_date ||= Date.today
    self.due_date ||= Chronic.parse('two weeks from today')
  end

  def self.over_due_rentals #returns array of Customer objects
    rentals = Rental.where("due_date < ?", Date.today)
    overdue_rentals = rentals.where.not('checkin_date': nil)

    customers_with_overdue = []
    overdue_rentals.each do |rental|
      customers_with_overdue << Customer.find_by_id(rental.customer_id)
    end
    return customers_with_overdue
  end




end
