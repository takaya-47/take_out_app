class VisitTime < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '本日' },
    { id: 2, name: '明日' },
    { id: 3, name: 'あさって' }
  ]

  include ActiveHash::Associations
  has_many :orderdetail
end
