class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.integer :movie_id
      t.integer :customer_id
      t.string :due_date
      t.datetime :check_in

      t.timestamps
    end
  end
end
