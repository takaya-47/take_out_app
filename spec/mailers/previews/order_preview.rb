# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order/send_when_order
  def send_when_order
    # 引数に入れるためのインスタンスを生成しておく
    orderOrderDetail = OrderOrderDetail.new(quantity: 1, total_price: 1000, last_name: 'たなか', first_name: 'たろう', last_name_kana: 'タナカ', first_name_kana: 'タロウ', prefecture_id: 1, address: '田中市', phone_number: '090-1234-4321', visit_day_id: 1, visit_time_id: 1, menu_id: 1, token: 'token')
    # 作成したインスタンスを引数にとり、メール送信の記述をする
    OrderMailer.send_when_order(orderOrderDetail)
  end

end
