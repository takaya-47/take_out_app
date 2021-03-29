class Order < ApplicationRecord
  belongs_to :menu
  has_one :order_detail, dependent: :destroy
  # バリデーションはフォームオブジェクトクラスに記述
end
