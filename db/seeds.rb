# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
  user = User.create!(
    shop_name: "お店#{ n + 1 }",
    email: "seed#{ n + 1 }@seed.com",
    password: "pass1234",
    password_confirmation: "pass1234",
    category_id: rand(1..10),
    prefecture_id: rand(1..47),
    address: "仮町仮番地123-1",
    business_hours: "9時〜17時",
    holiday: "月曜",
    phone_number: "090-1234-5678",
    image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("db/fixtures/sample_user.jpeg")), filename: "sample_user.jpeg")
  )
end

20.times do |n|
  menu = Menu.create!(
    name: "メニュー#{ n + 1 }"
    price: rand(800..4000)
    explain: "当店人気ナンバー１です！"
    user_id: rand(1..23)
    image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("db/fixtures/sample_menu.jpeg")), filename: "sample_menu.jpeg")
  )
end