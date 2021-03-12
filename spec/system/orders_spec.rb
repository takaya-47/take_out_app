require 'rails_helper'

RSpec.describe 'メニューの注文', type: :system do
  before do
    @menu = FactoryBot.create(:menu)
    @orderOrderDetail = FactoryBot.build(:order_order_detail, menu_id: @menu.id)
    @mail = OrderMailer.send_when_order(@orderOrderDetail)
  end

  it 'サイト来訪者はメニューの注文ができる' do
    visit root_path
    all('.contents-box')[0].click_link nil, href: menu_path(@menu)
    expect(page).to have_content('注文する')
    click_on '注文する'
    expect(page).to have_content('注文画面')
    expect(page).to have_selector 'img.pic'
    expect(page).to have_content(@menu.user.shop_name)
    expect(page).to have_content(@menu.name)
    expect(page).to have_content(@menu.price)
    expect(page).to have_content(@menu.explain)
    fill_in 'カード番号', with: '4242424242424242'
    fill_in 'CVC', with: '123'
    fill_in '有効期限（月）', with: 3
    fill_in '有効期限（年）', with: 33
    fill_in '数量', with: @orderOrderDetail.quantity
    fill_in '合計金額（税込）', with: @orderOrderDetail.total_price
    fill_in '名前（姓）', with: @orderOrderDetail.last_name
    fill_in '名前（名）', with: @orderOrderDetail.first_name
    fill_in 'フリガナ（姓）', with: @orderOrderDetail.last_name_kana
    fill_in 'フリガナ（名）', with: @orderOrderDetail.first_name_kana
    select '北海道', from: '住所（都道府県）'
    fill_in '住所（市町村以下）', with: @orderOrderDetail.address
    fill_in '電話番号', with: @orderOrderDetail.phone_number
    select '本日', from: '来店日'
    select '7時〜8時', from: '来店時間'
    # モックを作成
    charge_mock = double('RSpec charge')
    # モックがcreateメソッドを呼び出せるようにする
    allow(charge_mock).to receive(:create)
    # Payjp::Chargeオブジェクトにcreateアクションが呼ばれたらモックを使うようにする
    allow(Payjp::Charge).to receive(:create).and_return(charge_mock)
    expect do
      click_on '注文する'
    end.not_to raise_error
    expect(@mail.to).to eq [@menu.user.email]
    expect(page).to have_content('ご注文ありがとうございます！')
  end
end

# expect{
#   click_on '注文する'
# }.to change{ ActionMailer::Base.deliveries.size }.by(1)
