require 'rails_helper'

RSpec.describe 'deviseのメーラーテスト', type: :mailer do
  let(:user) { FactoryBot.create(:user) }
  token = 'abcdef'
  let(:mail) { Devise::Mailer.reset_password_instructions(user, token) }

  it 'パスワードリセットメールのヘッダー情報が正しいか' do
    expect(mail.subject).to eq('パスワードの再設定について')
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq(['noreply@example.com'])
  end

  it 'メール本文が正しいか' do
    mail.deliver_now
    last_mail = ActionMailer::Base.deliveries.last
    expect(last_mail.body.to_s).to match(user.shop_name)
    expect(last_mail.body.to_s).to match(token)
  end

  it 'メールの件数が1件増えているか' do
    expect{
      mail.deliver_now
    }.to change{ ActionMailer::Base.deliveries.size }.by(1)
  end

end