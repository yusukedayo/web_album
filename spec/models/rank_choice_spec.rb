# == Schema Information
#
# Table name: rank_choices
#
#  id            :bigint           not null, primary key
#  answers_count :integer          default(0)
#  content       :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rank_id       :bigint           not null
#
# Indexes
#
#  index_rank_choices_on_rank_id  (rank_id)
#
# Foreign Keys
#
#  fk_rails_...  (rank_id => ranks.id)
#
require 'rails_helper'

RSpec.describe RankChoice, type: :model do
  describe 'バリデーション' do
    it 'contentが存在し、contentが255字以内の場合有効であること' do
      rank_choice = build(:rank_choice)
      expect(rank_choice).to be_valid
      expect(rank_choice.errors).to be_empty
    end

    it 'contentが無い場合不正であること' do
      rank_choice_without_content = build(:rank_choice, content: nil)
      expect(rank_choice_without_content).to be_invalid
      expect(rank_choice_without_content.errors[:content]).to eq ['を入力してください']
    end

    it 'contentが20文字の場合有効であること' do
      rank_choice_with_20_character_content = build(:rank_choice, content: 'a' * 20)
      expect(rank_choice_with_20_character_content).to be_valid
      expect(rank_choice_with_20_character_content.errors).to be_empty
    end

    it 'contentが21文字の場合不正であること' do
      rank_choice_with_21_character_content = build(:rank_choice, content: 'a' * 21)
      expect(rank_choice_with_21_character_content).to be_invalid
      expect(rank_choice_with_21_character_content.errors[:content]).to eq ['は20文字以内で入力してください']
    end
  end
end
