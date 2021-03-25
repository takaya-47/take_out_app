class User < ApplicationRecord
  has_many :menus

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category

  has_one_attached :image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # パスワードは半角英数混合で８文字
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8}\z/i }, on: :create
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8}\z/i, message: 'は半角英数混合で8文字です' }, allow_blank: true,
                       on: :update
  with_options presence: true do
    validates :shop_name
    validates :address
    validates :business_hours
    validates :holiday
    validates :image
    validates :phone_number, format: { with: /\A0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}\z/ }
    with_options numericality: { other_than: 0, message: 'を選択してください' } do
      validates :category_id
      validates :prefecture_id
    end
  end

  def update_without_current_password(params)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    update(params)
  end
end
