require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class.new(user, category) }
  let(:category) { Category.new }

  context 'with admin' do
    let(:user) { User.new(role: 1) }

    it { is_expected.to permit_only_actions(%i[index show new create edit update]) }
  end
end
