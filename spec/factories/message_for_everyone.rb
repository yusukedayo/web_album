FactoryBot.define do
  factory :message_for_everyone do
    sequence(:body) { |n| "message_#{n}" }
    user
    graduation_album
  end
end
