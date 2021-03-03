class Category < ActiveHash::Base
  self.data = [
    {id: 0, name: "和食"},
    {id: 1, name: "イタリアン"},
    {id: 2, name: "フレンチ"},
    {id: 3, name: "中華"},
    {id: 4, name: "アジア・エスニック"},
    {id: 5, name: "ファーストフード"},
    {id: 6, name: "カフェ・喫茶"},
    {id: 7, name: "スイーツ"},
    {id: 8, name: "パン屋"},
    {id: 9, name: "その他"}
  ]

  include ActiveHash::Associations
  has_many :users
end