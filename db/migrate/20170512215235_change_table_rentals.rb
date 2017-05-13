class ChangeTableRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :customer_id, :integer
    add_column :rentals, :movie_id, :integer
    add_column :rentals, :due_date, :string
  end
end
