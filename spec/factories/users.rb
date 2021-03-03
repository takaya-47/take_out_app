FactoryBot.define do
  factory :user do
    shop_name { Faker::Company.name }
    email { Faker::Internet.free_email }
    password = 'Pass1234'
    password { password }
    password_confirmation { password }
    category_id { 1 }
    prefecture_id { 1 }
    address { '札幌市1-1' }
    business_hours { '８時〜20時' }
    holiday { '水曜定休' }
    phone_number { '03-1234-5678' }

    after(:build) do |user|
      user.image.attach(io: File.open('app/assets/images/test.jpeg'), filename: 'test.jpeg')
    end
  end
end
