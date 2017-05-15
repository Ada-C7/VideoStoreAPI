class AddColumnstoMoviesandCustomerMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :available_inventory, :integer
    add_column :customer_movies, :checkout_date, :string
    add_column :customer_movies, :due_date, :string
  end
end
