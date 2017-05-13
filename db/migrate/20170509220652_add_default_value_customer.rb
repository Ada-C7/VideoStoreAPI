class AddDefaultValueCustomer < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :account_credit, :float, :default => 0.0
  end
end
