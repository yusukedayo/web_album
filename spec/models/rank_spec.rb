# == Schema Information
#
# Table name: ranks
#
#  id                  :bigint           not null, primary key
#  rank_description    :text             not null
#  rank_title          :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_ranks_on_graduation_album_id  (graduation_album_id)
#  index_ranks_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Rank, type: :model do
  describe 'バリデーション' do
    it 'タイトル、詳細が存在し、タイトルが255字、詳細が65535字以内の場合有効であること' do
      rank = build(:rank)
      expect(rank).to be_valid
      expect(rank.errors).to be_empty
    end

    it 'タイトルが無い場合不正であること' do
      rank_without_rank_title = build(:rank, rank_title: nil)
      expect(rank_without_rank_title).to be_invalid
      expect(rank_without_rank_title.errors[:rank_title]).to eq ['を入力してください']
    end

    it '詳細が無い場合不正であること' do
      rank_without_rank_description = build(:rank, rank_description: nil)
      expect(rank_without_rank_description).to be_invalid
      expect(rank_without_rank_description.errors[:rank_description]).to eq ['を入力してください']
    end

    it '詳細が65535文字の場合有効であること' do
      rank_with_65535_character_rank_description = build(:rank, rank_description: 'a' * 65_535)
      expect(rank_with_65535_character_rank_description).to be_valid
      expect(rank_with_65535_character_rank_description.errors).to be_empty
    end

    it '詳細が65536文字の場合不正であること' do
      rank_with_256_character_rank_description = build(:rank, rank_description: 'a' * 65_536)
      expect(rank_with_256_character_rank_description).to be_invalid
      expect(rank_with_256_character_rank_description.errors[:rank_description]).to eq ['は65535文字以内で入力してください']
    end

    it 'タイトルが255文字の場合有効であること' do
      rank_with_65535_character_rank_title = build(:rank, rank_title: 'a' * 255)
      expect(rank_with_65535_character_rank_title).to be_valid
      expect(rank_with_65535_character_rank_title.errors).to be_empty
    end

    it 'タイトルが256文字の場合不正であること' do
      rank_with_256_character_rank_title = build(:rank, rank_title: 'a' * 256)
      expect(rank_with_256_character_rank_title).to be_invalid
      expect(rank_with_256_character_rank_title.errors[:rank_title]).to eq ['は255文字以内で入力してください']
    end
  end
end
