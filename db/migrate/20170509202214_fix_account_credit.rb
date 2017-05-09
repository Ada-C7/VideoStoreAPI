class FixAccountCredit < ActiveRecord::Migration[5.0]
  def change
    change_column :customer, :account_credit, :float
  end
end
