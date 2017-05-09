class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.boolean :checked_out
      t.date :due_date
      t.belongs_to :customer
      t.belongs_to :movie

      t.timestamps
    end
  end
end
