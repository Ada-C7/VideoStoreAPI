class AddAvailableToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :available_inventory, :integer
  end
end
