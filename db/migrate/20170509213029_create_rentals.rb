class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.belongs_to :customer
      t.belongs_to :movie
      t.date :due_date
      t.timestamps
    end
  end
end
