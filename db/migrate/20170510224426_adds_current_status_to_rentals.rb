class AddsCurrentStatusToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :is_current, :boolean
    remove_column :rentals, :checkout_date, :string
  end
end
