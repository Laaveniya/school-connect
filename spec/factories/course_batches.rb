# frozen_string_literal: true

FactoryBot.define do
  factory :course_batch do
    name { "Course Batch" }
    max_enrollment_count { 10 }
    start_date { Date.today }
    end_date { Date.today + 1.month }
    course { create(:course) }
    creator { create(:user) }
  end
end