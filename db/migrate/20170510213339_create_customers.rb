class CreateCustomers < ActiveRecord::Migration[5.0]
     def change
          create_table :customers do |t|
               t.string :name
               t.date :registered_at
               t.string :postal_code
               t.string :phone
               t.integer :movies_checked_out_count
               t.timestamps
          end
     end
end
