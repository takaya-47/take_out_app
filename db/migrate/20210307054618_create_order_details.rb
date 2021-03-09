class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.integer    :quantity,        null: false
      t.integer    :totoal_price,    null: false
      t.string     :last_name,       null: false
      t.string     :first_name,      null: false
      t.string     :last_name_kana,  null: false
      t.string     :first_name_kana, null: false
      t.integer    :prefecture_id,   null: false
      t.string     :address,         null: false
      t.string     :phone_number,    null: false
      t.integer    :visit_time_id,   null: false
      t.references :order,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
