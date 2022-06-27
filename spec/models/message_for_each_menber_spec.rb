# frozen_string_literal: true

# == Schema Information
#
# Table name: message_for_each_menbers
#
#  id                  :bigint           not null, primary key
#  body                :text             not null
#  to_user             :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_message_for_each_menbers_on_graduation_album_id  (graduation_album_id)
#  index_message_for_each_menbers_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe MessageForEachMenber, type: :model do
  describe 'バリデーション' do
    it 'メッセージが存在し、65535字以内の場合有効であること' do
      message_for_each_menber = build(:message_for_each_menber)
      expect(message_for_each_menber).to be_valid
      expect(message_for_each_menber.errors).to be_empty
    end
    it 'メッセージが無い場合不正であること' do
      message_for_each_menber_without_body = build(:message_for_each_menber, body: nil)
      expect(message_for_each_menber_without_body).to be_invalid
      expect(message_for_each_menber_without_body.errors[:body]).to eq ['を入力してください']
    end
    it 'タイトルが255文字の場合有効であること' do
      message_for_each_menber_with_65535_character_body = build(:message_for_each_menber, body: 'a' * 65_535)
      expect(message_for_each_menber_with_65535_character_body).to be_valid
      expect(message_for_each_menber_with_65535_character_body.errors).to be_empty
    end
    it 'タイトルが256文字の場合不正であること' do
      message_for_each_menber_with_256_character_body = build(:message_for_each_menber, body: 'a' * 65_536)
      expect(message_for_each_menber_with_256_character_body).to be_invalid
      expect(message_for_each_menber_with_256_character_body.errors[:body]).to eq ['は65535文字以内で入力してください']
    end
  end
end
