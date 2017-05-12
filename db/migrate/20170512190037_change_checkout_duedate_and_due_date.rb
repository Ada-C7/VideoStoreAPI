class ChangeCheckoutDuedateAndDueDate < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :due_date, :date
    add_column :rentals, :checkout_date, :date
  end
end
