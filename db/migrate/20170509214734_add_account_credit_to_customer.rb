class AddAccountCreditToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :account_credit, :decimal
  end
end
