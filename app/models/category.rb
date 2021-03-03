class Category < ActiveHash::Base
  self.data = [
    {id: 0, name: '--'},
    {id: 1, name: "和食"},
    {id: 2, name: "イタリアン"},
    {id: 3, name: "フレンチ"},
    {id: 4, name: "中華"},
    {id: 5, name: "アジア・エスニック"},
    {id: 6, name: "ファーストフード"},
    {id: 7, name: "カフェ・喫茶"},
    {id: 8, name: "スイーツ"},
    {id: 9, name: "パン屋"},
    {id: 10, name: "その他"}
  ]

  include ActiveHash::Associations
  has_many :users
end