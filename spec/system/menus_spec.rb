require 'rails_helper'

RSpec.describe "メニュー新規投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.build(:menu)
  end

  it "ログインしたユーザーはメニューの新規投稿ができる" do
    log_in(@user)
    visit root_path
    expect(page).to have_link('メニュー投稿')
    visit new_menu_path
    expect(page).to have_content('新規メニュー登録')
    fill_in 'メニュー名', with: @menu.name
    fill_in '金額', with: @menu.price
    fill_in 'メニューの説明', with: @menu.explain
    attach_file '料理写真', "#{Rails.root}/app/assets/images/test.jpeg"
    expect{
      click_on '登録する'
    }.to change{ Menu.count }.by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content("メニューを投稿しました！")
  end

end

RSpec.describe "メニュー編集・削除", type: :system do
  before do
    @menu = FactoryBot.create(:menu)
  end

  it "自分が投稿したメニューはマイページから辿って編集できる" do
    log_in(@menu.user)
    visit root_path
    expect(page).to have_link(@menu.user.shop_name)
    visit user_path(@menu.user)
    expect(page).to have_link nil, href: menu_path(@menu)
    visit menu_path(@menu)
    click_on 'メニュー詳細を変更する'
    fill_in 'メニュー名', with: @menu.name
    fill_in '金額', with: @menu.price
    fill_in 'メニューの説明', with: @menu.explain
    attach_file '料理写真', "#{Rails.root}/app/assets/images/test.jpeg"
    click_on '登録する'
    expect(current_path).to eq menu_path(@menu)
    expect(page).to have_content("メニューを変更しました！")
  end

  it "自分が投稿したメニューは削除できる" do
    log_in(@menu.user)
    visit root_path
    expect(page).to have_link(@menu.user.shop_name)
    visit user_path(@menu.user)
    expect(page).to have_link nil, href: menu_path(@menu)
    visit menu_path(@menu)
    expect{
      click_on('このメニューを削除する')
    }.to change{ Menu.count }.by(-1)
    expect(current_path).to eq user_path(@menu.user)
    expect(page).to have_content("メニューを削除しました！")
  end
end

RSpec.describe 'メニュー詳細ページ', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.create(:menu)
  end

  it "ログインしていなくてもメニュー詳細ページが表示される" do
    visit root_path
    all('.contents-box')[0].click_link nil, href: menu_path(@menu)
    expect(page).to have_content("メニュー詳細")
    expect(page).to have_content @menu.user.shop_name
    expect(page).to have_content @menu.name
    expect(page).to have_content @menu.price
    expect(page).to have_content @menu.explain
    expect(page).to have_content("注文する")
  end
end