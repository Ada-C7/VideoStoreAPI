class AddMoviesCoCountToCustomersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :movies_checkout_out_count, :integer
  end
end
