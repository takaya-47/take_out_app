require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'GET #show' do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
      get user_path(@user)
      expect(response.status).to eq 200
    end

    it "showアクションにリクエストするとタイトルが表示されている" do
      get user_path(@user)
      expect(response.body).to include("店舗詳細", "提供中のメニュー")
    end
  end

  describe 'Get index' do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get users_path
      expect(response.status).to eq 200
    end

    it "indexアクションにリクエストするとタイトルが表示されている" do
      get users_path
      expect(response.body).to include("登録店舗一覧")
    end
  end
end
