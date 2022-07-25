# frozen_string_literal: true

# == Schema Information
#
# Table name: graduation_albums
#
#  id         :bigint           not null, primary key
#  album_name :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_graduation_albums_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe GraduationAlbum, type: :model do
  fdescribe 'バリデーション' do
    it 'アルバム名が存在し、どちらも255字以内の場合有効であること' do
      graduation_album = build(:graduation_album)
      expect(graduation_album).to be_valid
      expect(graduation_album.errors).to be_empty
    end

    it 'アルバム名が無い場合不正であること' do
      graduation_album_without_album_name = build(:graduation_album, album_name: nil)
      expect(graduation_album_without_album_name).to be_invalid
      expect(graduation_album_without_album_name.errors[:album_name]).to eq ['を入力してください']
    end

    it 'アルバム名が255文字の場合有効であること' do
      graduation_album_with_255_character_album_name = build(:graduation_album, album_name: 'a' * 255)
      expect(graduation_album_with_255_character_album_name).to be_valid
      expect(graduation_album_with_255_character_album_name.errors).to be_empty
    end

    it 'アルバム名が256文字の場合不正であること' do
      graduation_album_with_256_character_album_name = build(:graduation_album, album_name: 'a' * 256)
      expect(graduation_album_with_256_character_album_name).to be_invalid
      expect(graduation_album_with_256_character_album_name.errors[:album_name]).to eq ['は255文字以内で入力してください']
    end
  end
end
