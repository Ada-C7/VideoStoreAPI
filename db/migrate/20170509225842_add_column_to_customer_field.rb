class AddColumnToCustomerField < ActiveRecord::Migration[5.0]
  def change
        add_column :customers, :movies_checked_out_count, :integer
  end
end
