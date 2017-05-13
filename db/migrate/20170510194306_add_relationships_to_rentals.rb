class AddRelationshipsToRentals < ActiveRecord::Migration[5.0]
  def change
    add_reference :rentals, :customer, foreign_key: true
    add_reference :rentals, :movie, foreign_key: true
    remove_column :customers, :movies_checked_out_count
    add_column :customers, :rentals_count, :integer, default: 0
  end
end
