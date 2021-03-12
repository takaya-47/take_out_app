require 'rails_helper'

# メールの単体テストでは①メールが送信・作成されていること、②メールの中身が適切であることの２つをテストする。結合テストではメールが適切なタイミングで適切な相手に送られているかをチェックする（Railsガイド 「テスティングガイド」の「メイラーをテストする」より）

RSpec.describe OrderMailer, type: :mailer do
  describe 'send_when_orderメソッドで送るメールの検証' do
    let(:user) { FactoryBot.create(:user) }
    let(:menu) { FactoryBot.create(:menu, user_id: user.id) }
    let(:orderOrderDetail) { FactoryBot.build(:order_order_detail, menu_id: menu.id) }
    let(:mail) { OrderMailer.send_when_order(orderOrderDetail) }

    it 'メールのヘッダー情報が正しいか' do
      expect(mail.subject).to eq('注文のお知らせ')
      expect(mail.to).to eq [menu.user.email]
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'メール本文が正しいか' do
      # メールを送信する
      mail.deliver_now
      # 一番新しい送信済みメールを取得する
      last_mail = ActionMailer::Base.deliveries.last
      # 送信したメール本文の文面をチェック
      expect(last_mail.html_part.body.to_s).to match('注文のお知らせ')
      expect(last_mail.text_part.body.to_s).to match('注文のお知らせ')
    end

    it 'メールを実際に送り、作成できているか' do
      expect do
        mail.deliver_now
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
