module TestHelper
  # ログイン用のメソッド
  def log_in(user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'ログインする'
    expect(current_path).to eq root_path
  end
end
