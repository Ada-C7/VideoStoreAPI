class RenameMovieCustomersTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :movie_customers, :rentals
  end
end
