class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :customers, :postal, :postal_code
  end
end
