require 'rails_helper'

RSpec.describe BookingPolicy do
  subject { described_class.new(user, booking) }
  let(:booking) { Booking.new }

  context 'with visitors' do
    let(:user) { User.new(role: 0) }

    it { is_expected.to permit_only_actions(%i[index show new create edit update user_export]) }
  end

  context 'with admin' do
    let(:user) { User.new(role: 1) }

    it { is_expected.to permit_only_actions(%i[index show new create edit update user_export admin_export]) }
  end
end
