# frozen_string_literal: true

FactoryBot.define do
  factory :school_membership do
    association :user
    association :school
    active { true }
  end
end
