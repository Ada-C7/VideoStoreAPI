class AddDueDateToRental < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :due_date, :datetime
  end
end
