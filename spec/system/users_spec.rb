require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "ユーザー新規登録ができるとき" do
      it "正しい情報を入力すればユーザー登録ができ、トップページへ遷移する" do

      end
    end

    context "ユーザー新規登録ができないとき" do
      it "誤った情報を入力すると登録できずに新規登録ページに戻る" do
        
      end
    end
  end
end
