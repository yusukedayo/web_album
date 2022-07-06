# frozen_string_literal: true

FactoryBot.define do
  factory :graduation_album do
    sequence(:album_name) { |n| "album_name_#{n}" }
    user
  end
end
