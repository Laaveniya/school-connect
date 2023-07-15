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
      it { is_expected.to be_able_to(:manage, Enrollment) }
      it { is_expected.to be_able_to(:manage, User) }
    end

    context 'when user is a school admin' do
      let(:user) { create(:school_admin) }
      let(:school) { create(:school) }
      let(:other_school) { create(:school) }
      let(:course_1) { create(:course, school: school) }
      let(:course_2) { create(:course, school: other_school) }
      let!(:course_batch_1) { create(:course_batch, course: course_1) }
      let!(:course_batch_2) { create(:course_batch, course: course_2) }
      let!(:adminship) { create(:adminship, user: user, school: school) }

      context 'school is administered by user' do
        before { user.schools_administered << school }

        it { is_expected.to be_able_to(:manage, school) }
        it { is_expected.to be_able_to(:manage, course_1) }
        it { is_expected.to be_able_to(:manage, course_batch_1) }
        it { is_expected.to be_able_to(:manage, Enrollment) }
        it { is_expected.to be_able_to(:approve, Enrollment.new(course_batch: course_batch_1)) }
        it { is_expected.to be_able_to(:deny, Enrollment.new(course_batch: course_batch_1)) }
        it { is_expected.to be_able_to(:manage, User, adminships: { school_id: school.id }) }
      end

      context 'school is not administered by user' do
        it { is_expected.not_to be_able_to(:manage, other_school) }
        it { is_expected.not_to be_able_to(:create, other_school) }
        it { is_expected.not_to be_able_to(:manage, course_2) }
        it { is_expected.not_to be_able_to(:manage, course_batch_2) }
        it { is_expected.not_to be_able_to(:manage, Enrollment.new(course_batch: course_batch_2)) }
        it { is_expected.not_to be_able_to(:approve, Enrollment.new(course_batch: course_batch_2)) }
        it { is_expected.not_to be_able_to(:deny, Enrollment.new(course_batch: course_batch_2)) }
      end
    end

    context 'when user is not an admin or school admin' do
      let(:user) { create(:user) }

      it { is_expected.not_to be_able_to(:manage, School) }
      it { is_expected.not_to be_able_to(:manage, Adminship) }
      it { is_expected.not_to be_able_to(:manage, Course) }
      it { is_expected.not_to be_able_to(:manage, CourseBatch) }
    end

    context 'when reading as a student' do
      let(:user) { create(:user, role: :student) }

      let(:school) { create(:school) }
      let(:course) { create(:course, school: school) }
      let(:course_batch) { create(:course_batch, course: course) }
      let!(:school_membership) { create(:school_membership, user: user, school: school) }
      let(:enrollment) { create(:enrollment, student: user, course_batch: course_batch) }

      it { is_expected.to be_able_to(:create, enrollment) }
      it { is_expected.to be_able_to(:read, enrollment) }
      it { is_expected.to be_able_to(:read, course_batch) }

      it 'denies access to course batches where the student is not enrolled' do
        other_course_batch = create(:course_batch)
        expect(ability).not_to be_able_to(:read, other_course_batch)
      end
    end

  end
end
