require 'rails_helper'

RSpec.describe Menu, type: :model do
  before do
    @menu = FactoryBot.build(:menu)
  end

  describe "メニューの新規投稿" do
    context "メニューの投稿ができるとき" do
      it "すべての情報が正しく入力されていれば投稿できる" do
        expect(@menu).to be_valid
      end
    end

    context "メニューの投稿ができないとき" do

    end
  end
end
