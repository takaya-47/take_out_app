class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :shop_name
    validates :address
    validates :business_hours
    validates :holiday
    validates :phone_number, format: { with: /0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}/ }
    with_options numericality: { other_than: 0 } do
      validates :category_id
      validates :prefecture_id
    end
  end
end
