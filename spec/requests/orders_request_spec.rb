require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  before do
    @menu = FactoryBot.create(:menu)
    @orderOrderDetail = FactoryBot.build(:order_order_detail)
  end

  describe "Get new" do
    it "newアクションにリクエストすると正常にレスポンスが返ってくる" do
      get new_menu_order_path(@menu)
      expect(response.status).to eq 200
    end

    it "newアクションにリクエストするとタイトルが表示されている" do
      get new_menu_order_path(@menu)
      expect(response.body).to include("注文画面")
    end

    it "newアクションにリクエストすると注文ボタンが表示されている" do
      get new_menu_order_path(@menu)
      expect(response.body).to include("注文する")
    end
  end
end
