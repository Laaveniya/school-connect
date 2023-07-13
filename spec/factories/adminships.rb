# frozen_string_literal: true

FactoryBot.define do
  factory :adminship do
    association :user
    association :school
  end
end
