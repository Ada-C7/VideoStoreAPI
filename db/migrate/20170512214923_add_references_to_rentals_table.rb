class AddReferencesToRentalsTable < ActiveRecord::Migration[5.0]
  def change
    add_reference :rentals, :customer, foreign_key: true
    add_reference :rentals, :movie, foreign_key: true
  end
end
