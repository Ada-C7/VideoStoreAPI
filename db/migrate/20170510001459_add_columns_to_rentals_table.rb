class AddColumnsToRentalsTable < ActiveRecord::Migration[5.0]
  def change
    add_reference :rentals, :customers, foreign_key: true
    add_reference :rentals, :movies, foreign_key: true
    add_column :rentals, :checkout_date, :string
    add_column :rentals, :due_date, :string
  end
end
