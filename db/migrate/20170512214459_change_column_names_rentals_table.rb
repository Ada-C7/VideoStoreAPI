class ChangeColumnNamesRentalsTable < ActiveRecord::Migration[5.0]
  def change
    remove_reference :rentals, :customers
    remove_reference :rentals, :movies
  end
end
