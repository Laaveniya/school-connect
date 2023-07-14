# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    start_date { Date.today }
    end_date { Date.today + 1.month }
    school { create(:school) }
    status { 0 }
  end
end
