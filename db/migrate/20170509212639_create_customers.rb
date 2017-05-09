class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :phone
      t.string :registered_at
      t.integer :movies_checked_out_count, default: 0
      t.timestamps
    end
  end
end
