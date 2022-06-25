# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageForEveryone, type: :model do
  describe 'バリデーション' do
    it 'メッセージが存在し、65535字以内の場合有効であること' do
      message_for_everyone = build(:message_for_everyone)
      expect(message_for_everyone).to be_valid
      expect(message_for_everyone.errors).to be_empty
    end

    it 'メッセージが無い場合不正であること' do
      message_for_everyone_without_body = build(:message_for_everyone, body: nil)
      expect(message_for_everyone_without_body).to be_invalid
      expect(message_for_everyone_without_body.errors[:body]).to eq ['を入力してください']
    end

    it 'タイトルが255文字の場合有効であること' do
      message_for_everyone_with_65535_character_body = build(:message_for_everyone, body: 'a' * 65_535)
      expect(message_for_everyone_with_65535_character_body).to be_valid
      expect(message_for_everyone_with_65535_character_body.errors).to be_empty
    end

    it 'タイトルが256文字の場合不正であること' do
      message_for_everyone_with_256_character_body = build(:message_for_everyone, body: 'a' * 65_536)
      expect(message_for_everyone_with_256_character_body).to be_invalid
      expect(message_for_everyone_with_256_character_body.errors[:body]).to eq ['は65535文字以内で入力してください']
    end
  end
end
