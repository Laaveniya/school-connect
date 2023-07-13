# frozen_string_literal: true

require 'rails_helper'

require 'cancan/matchers'

RSpec.describe Ability do
  describe 'admin abilities' do
    subject(:ability) { Ability.new(user) }

    context 'when user is an admin' do
      let(:user) { create(:admin_user) }

      it { is_expected.to be_able_to(:manage, School) }
      it { is_expected.to be_able_to(:manage, Adminship) }
    end

    context 'when user is a school admin' do
      let(:user) { create(:school_admin)  }
      let(:school) { create(:school) }
      let(:other_school) { create(:school) }
      let!(:adminship) { create(:adminship, user: user, school: school) }

      context 'school is administered by user' do
        before { user.schools_administered << school }

        it { is_expected.to be_able_to(:manage, school) }
      end

      context 'school is not administered by user' do
        it { is_expected.not_to be_able_to(:manage, other_school) }
      end
    end

    context 'when user is not an admin or school admin' do
      let(:user) { create(:user) }

      it { is_expected.not_to be_able_to(:manage, School) }
      it { is_expected.not_to be_able_to(:manage, Adminship) }
    end
  end
end
