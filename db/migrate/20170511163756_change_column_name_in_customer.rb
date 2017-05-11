class ChangeColumnNameInCustomer < ActiveRecord::Migration[5.0]
  def change
    rename_column :customers, :movies_checkout_out_count, :movies_checked_out_count
  end
end
