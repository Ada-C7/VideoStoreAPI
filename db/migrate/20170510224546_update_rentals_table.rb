class UpdateRentalsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :rentals, :checkout_date
    add_column :rentals, :check_in, :datetime
  end
end
