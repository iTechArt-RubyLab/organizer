require 'rails_helper'

RSpec.describe ServicePolicy do
  subject { described_class.new(user, service) }
  let(:service) { Service.new }

  context 'with visitors' do
    let(:user) { User.new(role: 0) }

    it { is_expected.to permit_only_actions(%i[index show search]) }
  end

  context 'with admin' do
    let(:user) { User.new(role: 1) }

    it { is_expected.to permit_only_actions(%i[index show new create edit update search]) }
  end
end
