# frozen_string_literal: true

FactoryBot.define do
  factory :school do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    creator { create(:user) }
  end
end

