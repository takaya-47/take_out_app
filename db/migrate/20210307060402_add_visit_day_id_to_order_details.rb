class AddVisitDayIdToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :visit_day_id, :integer, null: false
  end
end
