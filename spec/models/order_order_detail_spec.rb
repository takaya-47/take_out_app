require 'rails_helper'

RSpec.describe OrderOrderDetail, type: :model do
  before do
    # フォームオブジェクトクラスはFactoryBotでアソシエーションのインスタンスを定義できないのでここでMenuインスタンスを作成して保存
    @menu = FactoryBot.create(:menu)
    @orderOrderDetail = FactoryBot.build(:order_order_detail, menu_id: @menu.id)
    sleep 0.1
  end

  describe 'メニュー注文機能' do
    context 'メニュー注文ができるとき' do
      it 'すべての情報が正しく入力されていれば注文できる' do
        expect(@orderOrderDetail).to be_valid
      end

      it 'phone_numberは10桁でも注文できる' do
        @orderOrderDetail.phone_number = '03-1234-4321'
        expect(@orderOrderDetail).to be_valid
      end
    end

    context 'メニュー注文ができないとき' do
      it 'quantityがないと注文できない' do
        @orderOrderDetail.quantity = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include("Quantity can't be blank")
      end

      it 'quantityが0では注文できない' do
        @orderOrderDetail.quantity = 0
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Quantity must be greater than 0')
      end

      it 'quantityが101個以上では注文できない' do
        @orderOrderDetail.quantity = 101
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Quantity must be less than 101')
      end

      it 'total_priceがないと注文できない' do
        @orderOrderDetail.total_price = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include("Total price can't be blank")
      end

      it 'addressがないと注文できない' do
        @orderOrderDetail.address = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberがないと注文できない' do
        @orderOrderDetail.phone_number = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberはハイフンが必要' do
        @orderOrderDetail.phone_number = '09012344321'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberは0から始まる' do
        @orderOrderDetail.phone_number = '12312344321'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Phone number is invalid')
      end

      it 'menuがなければ注文できない' do
        @orderOrderDetail.menu_id = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include("Menu can't be blank")
      end

      it 'tokenがなければ注文できない' do
        @orderOrderDetail.token = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include("Token can't be blank")
      end

      it 'prefecture_idがなければ注文できない' do
        @orderOrderDetail.prefecture_id = 0
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it 'visit_day_idがなければ注文できない' do
        @orderOrderDetail.visit_day_id = 0
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Visit day must be other than 0')
      end

      it 'visit_time_idがなければ注文できない' do
        @orderOrderDetail.visit_time_id = 0
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Visit time must be other than 0')
      end

      it 'last_nameがなければ注文できない' do
        @orderOrderDetail.last_name = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Last name is invalid')
      end

      it 'last_nameが半角英数では注文できない' do
        @orderOrderDetail.last_name = 'tanaka'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Last name is invalid')
      end

      it 'first_nameがなければ注文できない' do
        @orderOrderDetail.first_name = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('First name is invalid')
      end

      it 'first_nameが半角英数では注文できない' do
        @orderOrderDetail.first_name = 'ﾀﾛｳ'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('First name is invalid')
      end

      it 'last_name_kanaがなければ注文できない' do
        @orderOrderDetail.last_name_kana = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'last_name_kanaがひらがなだと注文できない' do
        @orderOrderDetail.last_name_kana = 'たなか'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'last_name_kanaが漢字だと注文できない' do
        @orderOrderDetail.last_name_kana = '田中'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'first_name_kanaがなければ注文できない' do
        @orderOrderDetail.first_name_kana = nil
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('First name kana is invalid')
      end

      it 'first_name_kanaがひらがなだと注文できない' do
        @orderOrderDetail.first_name_kana = 'たろう'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('First name kana is invalid')
      end

      it 'first_name_kanaが漢字だと注文できない' do
        @orderOrderDetail.first_name_kana = '太郎'
        @orderOrderDetail.valid?
        expect(@orderOrderDetail.errors.full_messages).to include('First name kana is invalid')
      end
    end
  end
end
