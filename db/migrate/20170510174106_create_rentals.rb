class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.belongs_to :movie
      t.belongs_to :customer
      t.date :check_out_date
      t.date :return_date
      t.date :due_date
      t.string :status
      t.timestamps
    end
  end
end
