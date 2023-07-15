# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    association :course_batch
    association :student, factory: :user
    association :approver, factory: :user
    status { 'approved' }
  end
end
