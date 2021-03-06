FactoryBot.define do
  factory :menu do
    name { "MyString" }
    price { 1 }
    explain { "MyText" }
    user { nil }
  end
end
