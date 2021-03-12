require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録登録ができるとき' do
      it 'すべての項目が適切に入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録登録ができないとき' do
      it 'パスワードが7文字以下だと登録できない' do
        @user.password = 'Pass123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは8文字以上で入力してください')
      end

      it 'パスワードが9文字以上だと登録できない' do
        @user.password = 'Pass12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'パスワードが全て半角英字だけだと登録できない' do
        @user.password = 'Password'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'パスワードが全て数字では登録できない' do
        @user.password = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'パスワードとパスワード確認が不一致だと登録できない' do
        @user.password = 'Pass1234'
        @user.password_confirmation = 'Pass5678'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it '店名がないと登録できない' do
        @user.shop_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("店名を入力してください")
      end

      it '住所がないと登録できない' do
        @user.address = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("住所を入力してください")
      end

      it '営業時間がないと登録できない' do
        @user.business_hours = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("営業時間を入力してください")
      end

      it '定休日がないと登録できない' do
        @user.holiday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("定休日を入力してください")
      end

      it '電話番号がないと登録できない' do
        @user.phone_number = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号はハイフンが必要' do
        @user.phone_number = '09012345678'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号が9桁以下だと登録できない' do
        @user.phone_number = '01-2345-678'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号が12桁以上だと登録できない' do
        @user.phone_number = '080-1234-56789'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'カテゴリーを選択しなければ登録できない' do
        @user.category_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include('カテゴリーを選択してください')
      end

      it '都道府県を選択しなければ登録できない' do
        @user.prefecture_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include('都道府県を選択してください')
      end

      it '画像がなければ登録できない' do
        @user.image = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("店舗写真を入力してください")
      end
    end
  end
end
