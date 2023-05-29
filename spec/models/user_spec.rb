require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '12345',
                             info: { name: 'Test User', email: 'test@example.com',
                                     image: 'https://example.com/avatar.png' })
    end

    context 'when user exists' do
      let!(:existing_user) { create(:user, provider: 'google_oauth2', uid: '12345') }

      it 'returns the existing user' do
        expect(described_class.from_omniauth(auth)).to eq(existing_user)
      end
    end

    context 'when user does not exist' do
      it 'creates a new user with the provided attributes' do
        expect { described_class.from_omniauth(auth) }.to change(User, :count).by(1)

        new_user = User.last
        expect(new_user.provider).to eq('google_oauth2')
        expect(new_user.uid).to eq('12345')
        expect(new_user.name).to eq('Test User')
        expect(new_user.email).to eq('test@example.com')
        expect(new_user.avatar_url).to eq('https://example.com/avatar.png')
      end
    end
  end

  describe '#soft_delete' do
    let(:user) { create(:user) }
    let(:time) { Time.zone.parse('May 25 2023') }

    it 'sets the deleted_at attribute to the current time' do
      allow(Time).to receive(:current).and_return(time)

      expect do
        user.soft_delete
      end.to change(user, :deleted_at).from(nil).to(Time.current)
    end
  end

  describe '#active_for_authentication?' do
    let(:user) { create(:user) }

    context 'when the user is deleted' do
      before { user.soft_delete }

      it 'returns false' do
        expect(user.active_for_authentication?).to eq(false)
      end
    end
  end

  describe '#inactive_message' do
    let(:user) { create(:user) }

    context 'when the user is deleted' do
      before { user.soft_delete }

      it 'returns :deleted_account' do
        expect(user.inactive_message).to eq(:deleted_account)
      end
    end
  end
end
