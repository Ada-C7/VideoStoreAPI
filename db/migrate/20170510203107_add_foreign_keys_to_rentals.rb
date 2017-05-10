class AddForeignKeysToRentals < ActiveRecord::Migration[5.0]
  def change
    add_reference :rentals, :movie
    add_reference :rentals, :customer
  end
end
