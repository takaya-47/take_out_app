require 'rails_helper'

RSpec.describe Menu, type: :model do
  before do
    @menu = FactoryBot.build(:menu)
  end

  describe 'メニューの新規投稿' do
    context 'メニューの投稿ができるとき' do
      it 'すべての情報が正しく入力されていれば投稿できる' do
        expect(@menu).to be_valid
      end
    end

    context 'メニューの投稿ができないとき' do
      it 'nameがなければ投稿できない' do
        @menu.name = nil
        @menu.valid?
        expect(@menu.errors.full_messages).to include("Name can't be blank")
      end

      it 'explainがなければ投稿できない' do
        @menu.explain = nil
        @menu.valid?
        expect(@menu.errors.full_messages).to include("Explain can't be blank")
      end

      it 'imageがなければ投稿できない' do
        @menu.image = nil
        @menu.valid?
        expect(@menu.errors.full_messages).to include("Image can't be blank")
      end

      it 'priceがなければ投稿できない' do
        @menu.price = nil
        @menu.valid?
        expect(@menu.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが0だと投稿できない' do
        @menu.price = 0
        @menu.valid?
        expect(@menu.errors.full_messages).to include('Price must be greater than 0')
      end

      it 'priceがマイナスの値だと投稿できない' do
        @menu.price = -1000
        @menu.valid?
        expect(@menu.errors.full_messages).to include('Price must be greater than 0')
      end

      it 'priceが1000000以上だと投稿できない' do
        @menu.price = 1_000_000
        @menu.valid?
        expect(@menu.errors.full_messages).to include('Price must be less than 1000000')
      end

      it 'priceが全角で入力されていると投稿できない' do
        @menu.price = '１０００'
        @menu.valid?
        expect(@menu.errors.full_messages).to include('Price is not a number')
      end

      it 'priceに半角英字が含まれていると投稿できない' do
        @menu.price = '100o'
        @menu.valid?
        expect(@menu.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
