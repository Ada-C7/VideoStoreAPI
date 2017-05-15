class ChangeDueDateType < ActiveRecord::Migration[5.0]
  def change
    remove_column :rentals, :due_date , :string
    add_column :rentals, :due_date , :datetime
  end
end
