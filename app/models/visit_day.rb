class VisitDay < ActiveHash::Base
  self.data = [
    { id: 0, name: '選択してください' },
    { id: 1, name: '本日' },
    { id: 2, name: '明日' },
    { id: 3, name: 'あさって' }
  ]

  include ActiveHash::Associations
  has_many :order_details
end
