class RemoveMovieCheckOutandAvailInventory < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :available_inventory
    remove_column :customers, :movies_checked_out_count
  end
end
