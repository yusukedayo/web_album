FactoryBot.define do
  factory :rank_choice do
    sequence(:content) { |n| "選択肢_#{n}" }
    rank
  end
end