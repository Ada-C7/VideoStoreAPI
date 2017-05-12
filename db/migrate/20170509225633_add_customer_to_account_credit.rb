class AddCustomerToAccountCredit < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :account_credit, :float
  end
end
