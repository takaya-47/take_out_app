require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー登録ができ、トップページへ遷移する' do
      visit root_path
      expect(page).to have_link('新規登録')
      visit new_user_registration_path
      fill_in '店舗名', with: @user.shop_name
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード（確認）', with: @user.password_confirmation
      select '和食', from: 'カテゴリー'
      select '北海道', from: '都道府県'
      fill_in '住所', with: @user.address
      fill_in '営業時間', with: @user.business_hours
      fill_in '定休日', with: @user.holiday
      fill_in '電話番号', with: @user.phone_number
      attach_file '店舗写真', "#{Rails.root}/app/assets/images/test.jpeg"
      expect do
        click_on '登録する'
      end.to change { User.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content(@user.shop_name)
      expect(page).to have_link('メニュー投稿')
      expect(page).to have_link('ログアウト')
      expect(page).to have_no_link('新規登録')
      expect(page).to have_no_link('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報を入力すると登録できずに新規登録ページにとどまる' do
      visit root_path
      expect(page).to have_link('新規登録')
      visit new_user_registration_path
      fill_in '店舗名', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（確認）', with: ''
      select '--', from: 'カテゴリー'
      select '--', from: '都道府県'
      fill_in '住所', with: ''
      fill_in '営業時間', with: ''
      fill_in '定休日', with: ''
      fill_in '電話番号', with: ''
      expect  do
        click_on '登録する'
      end.to change { User.count }.by(0)
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    # ログインのためにはすでにユーザーが生成されている必要があるのでcreateを使う
    @user = FactoryBot.create(:user)
  end

  context 'ユーザーがログインできるとき' do
    it '正しい情報を入力すればログインできてトップページに遷移する' do
      visit root_path
      expect(page).to have_link('ログイン')
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on 'ログインする'
      expect(current_path).to eq root_path
    end
  end

  context 'ユーザーがログインできないとき' do
    it '誤った情報を入力するとログインできずにログインページにとどまる' do
      visit root_path
      expect(page).to have_link('ログイン')
      visit new_user_session_path
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_on 'ログインする'
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'indexアクション', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @category = Category.find(@user.category_id).name
    @prefecture = Prefecture.find(@user.prefecture_id).name
  end

  it '登録店舗一覧ページに店舗情報が掲載されている' do
    visit root_path
    expect(page).to have_link('登録店舗一覧')
    visit users_path
    expect(page).to have_selector 'img.image'
    expect(page).to have_content @user.shop_name
    expect(page).to have_content @category
    expect(page).to have_content @prefecture
    expect(page).to have_content @user.address
    expect(page).to have_content @user.business_hours
    expect(page).to have_content @user.holiday
  end
end

RSpec.describe 'showアクション', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @category = Category.find(@user.category_id).name
    @prefecture = Prefecture.find(@user.prefecture_id).name
  end

  it '店舗詳細ページに店舗情報が掲載されている' do
    visit root_path
    expect(page).to have_link('登録店舗一覧')
    visit users_path
    expect(page).to have_link nil, href: user_path(@user)
    visit user_path(@user)
    expect(page).to have_content('店舗詳細')
    expect(page).to have_content @category
    expect(page).to have_content @prefecture
    expect(page).to have_content @user.address
    expect(page).to have_content @user.business_hours
    expect(page).to have_content @user.holiday
    expect(page).to have_content @user.phone_number
  end
end

RSpec.describe 'edit, updateアクション', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ログインしているユーザーは自身の情報を編集でき、トップページに戻ってくる' do
    log_in(@user)
    visit user_path(@user)
    click_on '店舗情報を編集する'
    expect(page).to have_content('店舗情報編集')
    fill_in '店舗名', with: @user.shop_name
    fill_in 'メールアドレス', with: @user.email
    select '和食', from: 'カテゴリー'
    select '北海道', from: '都道府県'
    fill_in '住所', with: @user.address
    fill_in '営業時間', with: @user.business_hours
    fill_in '定休日', with: @user.holiday
    fill_in '電話番号', with: @user.phone_number
    attach_file '店舗写真', "#{Rails.root}/app/assets/images/test.jpeg"
    fill_in 'パスワード（新）', with: @user.password
    fill_in 'パスワード（確認）', with: @user.password_confirmation
    fill_in '現在のパスワード', with: @user.password
    click_on '更新する'
    expect(page).to have_content('アカウント情報を変更しました。')
    expect(current_path).to eq root_path
  end
end
