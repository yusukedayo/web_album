FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "イベントタイトル_#{n}" }
    sequence(:description) { |n| "このイベントの詳細#{n}" }
    event_date { '2022/07/08' }
    user
    graduation_album
  end
end