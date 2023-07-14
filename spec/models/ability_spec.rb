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
      it { is_expected.to be_able_to(:manage, Course) }
      it { is_expected.to be_able_to(:manage, CourseBatch) }
    end

    context 'when user is a school admin' do
      let(:user) { create(:school_admin)  }
      let(:school) { create(:school) }
      let(:other_school) { create(:school) }
      let!(:course_1) { create(:course, school: school)}
      let!(:course_2) { create(:course, school: other_school)}
      let!(:course_batch_1) { create(:course_batch, course: course_1)}
      let!(:course_batch_2) { create(:course_batch, course: course_2)}
      let!(:adminship) { create(:adminship, user: user, school: school) }

      context 'school is administered by user' do
        before { user.schools_administered << school }

        it { is_expected.to be_able_to(:manage, school) }
        it { is_expected.to be_able_to(:manage, course_1) }
        it { is_expected.to be_able_to(:manage, course_batch_1) }
      end

      context 'school is not administered by user' do
        it { is_expected.not_to be_able_to(:manage, other_school) }
        it { is_expected.not_to be_able_to(:create, other_school) }
        it { is_expected.not_to be_able_to(:manage, course_2) }
        it { is_expected.not_to be_able_to(:manage, course_batch_2) }
      end
    end

    context 'when user is not an admin or school admin' do
      let(:user) { create(:user) }

      it { is_expected.not_to be_able_to(:manage, School) }
      it { is_expected.not_to be_able_to(:manage, Adminship) }
      it { is_expected.not_to be_able_to(:manage, Course) }
      it { is_expected.not_to be_able_to(:manage, CourseBatch) }
    end
  end
end
