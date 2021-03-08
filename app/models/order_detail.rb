class OrderDetail < ApplicationRecord
  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :visit_time
  belongs_to :visit_day

  # バリデーションはフォームオブジェクトクラスに記述
end
