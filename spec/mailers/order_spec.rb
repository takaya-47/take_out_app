require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  describe "send_when_order" do
    let(:mail) { OrderMailer.send_when_order }

    it "renders the headers" do
      expect(mail.subject).to eq("Send when order")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
