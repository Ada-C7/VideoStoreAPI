class ChangeRentalCheckinToReturned < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :returned, :boolean, :default => false
  end
end
