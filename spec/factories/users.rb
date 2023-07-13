# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' }
    role { User.roles[:user] }
  end

  factory :admin_user, parent: :user do
    role { User.roles[:admin] }
  end

  factory :school_admin, parent: :user do
    role { User.roles[:school_admin] }
  end

  factory :student, parent: :user do
    role { User.roles[:student] }
  end
end







