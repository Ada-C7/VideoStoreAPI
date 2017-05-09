class AddColumnsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :title, :string
    add_column :movies, :overview, :string
    add_column :movies, :release_date, :string
    add_column :movies, :inventory, :integer
  end
end
