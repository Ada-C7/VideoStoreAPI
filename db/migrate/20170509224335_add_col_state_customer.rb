class AddColStateCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :state, :string
  end
end
