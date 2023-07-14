# frozen_string_literal

require 'rails_helper'

RSpec.describe CourseBatch, type: :model do
  let(:course_batch) { create(:course_batch) }
  subject { create(:course_batch) }
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:max_enrollment_count) }
    it { should validate_numericality_of(:max_enrollment_count).is_greater_than(0) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:course_id) }
  end

  context "associations" do
    it { should belong_to :course }
    it { should belong_to :creator }
  end
end
