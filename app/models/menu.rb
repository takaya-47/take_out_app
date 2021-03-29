class Menu < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :explain
    validates :image
  end
  validates :price, numericality: { greater_than: 0, less_than: 1_000_000 }
end
