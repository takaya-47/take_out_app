class OrderOrderDetail
  # フォームオブジェクトクラスであるのでライブラリを読み込む
  include ActiveModel::Model

  # このクラスで扱う属性を全て定義
  attr_accessor :quantity, :total_price, :last_name, :first_name, :last_name_kana, :first_name_kana, :prefecture_id, :address, :phone_number, :visit_day_id, :visit_time_id, :menu_id, :token

  # バリデーションを記述
  with_options presence:true do
    validates :quantity, numericality: { greater_than: 0, less_than: 101 }
    validates :total_price
    validates :address
    validates :phone_number, format: { with: /\A0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}\z/ }
    validates :menu_id
  end
  # そもそもリストから選ぶ形式なので0以外についてのみ制約を設ける
  with_options numericality: { other_than: 0 } do
    validates :prefecture_id
    validates :visit_day_id
    validates :visit_time_id
  end
  # 全角漢字、かな、カナがOK
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ } do
    validates :last_name
    validates :first_name
  end
  # 全角カナのみOK
  with_options format: { with: /\A[ァ-ヶ]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end

  # 以下にデータ保存の処理を記述
  def save
    order = Order.create(menu_id: menu_id)
    # 先に保存したorderインスタンスのidを使っている！
    OrderDetail.create!(quantity: quantity, total_price: total_price, last_name: last_name, first_name: first_name, last_name_kana: last_name_kana, first_name_kana: first_name_kana, prefecture_id: prefecture_id, address: address, phone_number: phone_number, visit_day_id: visit_day_id, visit_time_id: visit_time_id, order_id: order.id)
  end

end