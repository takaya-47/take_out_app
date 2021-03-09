class Order < ApplicationRecord
  belongs_to :menu
  # バリデーションはフォームオブジェクトクラスに記述
end
