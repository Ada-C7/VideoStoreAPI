class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.references :movie, foreign_key: true
      t.references :customer, foreign_key: true
      t.string :due_date

      t.timestamps
    end
  end
end
