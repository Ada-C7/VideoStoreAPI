class ChangeCheckoutDuedate < ActiveRecord::Migration[5.0]
  def change
    remove_column :rentals, :checkout_date
    remove_column :rentals, :due_date
    
  end
end
