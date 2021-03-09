FactoryBot.define do
  factory :order_order_detail do
    token { 'token' }
    quantity { 1 }
    total_price { 1080 }
    last_name { '田中' }
    first_name { '太郎' }
    last_name_kana { 'タナカ' }
    first_name_kana { 'タロウ' }
    prefecture_id { 1 }
    address { '仮番地123' }
    phone_number { '090-1234-4321' }
    visit_day_id { 1 }
    visit_time_id { 1 }

    # 関連するメニューインスタンスはここで作れないのでテストファイルで生成している
  end
end
