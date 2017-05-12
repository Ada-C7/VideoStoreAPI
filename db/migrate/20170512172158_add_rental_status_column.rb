class AddRentalStatusColumn < ActiveRecord::Migration[5.0]
  def change
      add_column :rentals, :checked_out, :boolean
  end
end
