require 'rails_helper'

RSpec.describe CompanyPolicy do
  subject { described_class.new(user, company) }
  let(:company) { Company.new }

  context 'with visitors' do
    let(:user) { User.new(role: 0) }

    it { is_expected.to permit_only_actions(%i[show]) }
  end

  context 'with admin' do
    let(:user) { User.new(role: 1) }

    it { is_expected.to permit_only_actions(%i[show edit update]) }
  end
end
