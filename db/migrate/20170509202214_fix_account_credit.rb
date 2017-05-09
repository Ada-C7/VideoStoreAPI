class FixAccountCredit < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :account_credit, :float
  end
end
