class FixingRentalsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :rentals, :customer_id
    remove_column :rentals, :movie_id

    add_reference :rentals, :customer
    add_reference :rentals, :movie


  end
end
