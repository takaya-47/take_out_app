class FixColumnNameToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :total_price, :integer, null: false
  end
end
