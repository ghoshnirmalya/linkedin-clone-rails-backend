require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "notify" do
    user = FactoryBot.build(:user)
    let(:mail) { UserMailer.welcome_email(user.id) }

    it "renders the headers" do
      user = FactoryBot.create(:user)

      expect(mail.subject).to eq("Getting started with LinkedIn Rails")
      expect(mail.from).to eq([ENV.fetch("SENDGRID_DOMAIN")])
      expect(mail.to).to eq([User.last.email])
    end
  end
end
