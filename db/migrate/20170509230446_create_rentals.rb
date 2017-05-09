class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.integer :movie_id, index: true
      t.integer :customer_id, index: true
      t.string :due_date
      t.timestamps
    end
  end
end
