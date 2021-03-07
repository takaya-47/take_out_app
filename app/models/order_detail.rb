class OrderDetail < ApplicationRecord
  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :visittime
  belongs_to :visitday

  # バリデーションはフォームオブジェクトクラスに記述
end
