FactoryBot.define do
  factory :menu do
    name { "オムライス" }
    price { 1000 }
    explain { "懐かしのオムライスです" }
    association :user

    after(:build) do |menu|
      menu.image.attach(io: File.open('app/assets/images/test.jpeg'), filename: 'test.jpeg')
    end
  end
end
