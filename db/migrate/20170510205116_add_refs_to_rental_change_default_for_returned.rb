class AddRefsToRentalChangeDefaultForReturned < ActiveRecord::Migration[5.0]
  def change
    change_column :rentals, :returned, :boolean, :default => false

    add_reference :rentals, :movie, index: true, foreign_key: true

    add_reference :rentals, :customer, index: true, foreign_key: true

  end
end
