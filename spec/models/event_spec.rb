# == Schema Information
#
# Table name: events
#
#  id                  :bigint           not null, primary key
#  description         :text             not null
#  event_date          :date
#  event_photos        :json
#  title               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_events_on_graduation_album_id  (graduation_album_id)
#  index_events_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'バリデーション' do
    it 'タイトル、詳細が存在し、タイトルが255字、詳細が65535字以内の場合有効であること' do
      event = build(:event)
      expect(event).to be_valid
      expect(event.errors).to be_empty
    end

    it 'タイトルが無い場合不正であること' do
      event_without_title = build(:event, title: nil)
      expect(event_without_title).to be_invalid
      expect(event_without_title.errors[:title]).to eq ['を入力してください']
    end

    it '詳細が無い場合不正であること' do
      event_without_description = build(:event, description: nil)
      expect(event_without_description).to be_invalid
      expect(event_without_description.errors[:description]).to eq ['を入力してください']
    end

    it '詳細が65535文字の場合有効であること' do
      event_with_65535_character_description = build(:event, description: 'a' * 65_535)
      expect(event_with_65535_character_description).to be_valid
      expect(event_with_65535_character_description.errors).to be_empty
    end

    it '詳細が65536文字の場合不正であること' do
      event_with_256_character_description = build(:event, description: 'a' * 65_536)
      expect(event_with_256_character_description).to be_invalid
      expect(event_with_256_character_description.errors[:description]).to eq ['は65535文字以内で入力してください']
    end

    it 'タイトルが255文字の場合有効であること' do
      event_with_65535_character_title = build(:event, title: 'a' * 255)
      expect(event_with_65535_character_title).to be_valid
      expect(event_with_65535_character_title.errors).to be_empty
    end

    it 'タイトルが256文字の場合不正であること' do
      event_with_256_character_title = build(:event, title: 'a' * 256)
      expect(event_with_256_character_title).to be_invalid
      expect(event_with_256_character_title.errors[:title]).to eq ['は255文字以内で入力してください']
    end
  end
end
