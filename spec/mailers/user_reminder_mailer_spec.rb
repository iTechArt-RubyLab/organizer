require 'rails_helper'

RSpec.describe UserReminderMailer, type: :mailer do
  describe 'remind mail' do
    include ActiveJob::TestHelper
    let(:user) { create(:user) }
    let(:booking) { create(:booking, user:) }
    let(:mail) { UserReminderMailer.remind_mail(booking, user) }

    it 'renders the subject' do
      expect(mail.subject).to eq('You booked a time for the service')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end
  end
end

