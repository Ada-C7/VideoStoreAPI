class FixLastMigration < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :returned, :boolean, :default => false
    remove_column :movies, :returned
    remove_column :rentals, :check_in
  end
end
