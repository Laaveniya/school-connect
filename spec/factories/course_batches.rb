# frozen_string_literal: true

FactoryBot.define do
  factory :course_batch do
    name { Faker::Name.name }
    max_enrollment_count { 10 }
    start_date { Date.today }
    end_date { Date.today + 1.month }
    course { create(:course) }
    creator { create(:user) }
  end
end