require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  before do
    @menu = FactoryBot.create(:menu)
  end

  describe "Get show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
      get menu_path(@menu)
      expect(response.status).to eq 200
    end

    it "showアクションにリクエストするとタイトルが表示されている" do
      get menu_path(@menu)
      expect(response.body).to include("メニュー詳細")
    end
  end
end
