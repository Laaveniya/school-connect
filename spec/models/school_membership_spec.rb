# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchoolMembership, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:school) }
  end

  describe 'scopes' do
    describe '.active' do
      let!(:active_membership) { create(:school_membership, active: true) }
      let!(:inactive_membership) { create(:school_membership, active: false) }

      it 'returns active school memberships' do
        expect(SchoolMembership.active).to eq([active_membership])
      end
    end
  end
end




