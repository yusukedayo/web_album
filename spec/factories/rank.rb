FactoryBot.define do
  factory :rank do
    sequence(:rank_title) { |n| "ランキングタイトル_#{n}" }
    sequence(:rank_description) { |n| "このランキングの詳細#{n}" }
    user
    graduation_album
  end
end