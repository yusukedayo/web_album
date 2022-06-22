# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
  end
end
