# frozen_string_literal: true

FactoryBot.define do
  factory :message_for_each_menber do
    sequence(:body) { |n| "message_#{n}" }
    to_user { user.id }
    user
    graduation_album
  end
end
