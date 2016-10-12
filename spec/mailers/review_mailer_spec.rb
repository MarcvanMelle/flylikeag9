require "rails_helper"

RSpec.describe ReviewMailer, type: :mailer do
  describe 'instructions' do
    let(:user) { FactoryGirl.create(:user) }
    let(:word) { FactoryGirl.create(:word, user: user)}
    let(:mail) { ReviewMailer.review_notification(user, word).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('You have a new review!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply.wordup@gmail.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.username)
    end
  end
end
