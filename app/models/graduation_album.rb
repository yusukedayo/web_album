# frozen_string_literal: true

# == Schema Information
#
# Table name: graduation_albums
#
#  id              :bigint           not null, primary key
#  album_name      :string           not null
#  analysis_status :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_graduation_albums_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class GraduationAlbum < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :message_for_everyones, dependent: :destroy
  has_many :message_for_each_menbers, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :ranks, dependent: :destroy
  has_many :album_users, dependent: :destroy
  has_many :users, through: :album_users, source: :user
  has_many :suprise_messages, dependent: :destroy
  has_many :photo_paths, dependent: :destroy

  validates :album_name, presence: true, length: { maximum: 255 }
  enum analysis_status: { before: 0, doing: 1, done: 2 }

  validate :validate_number_of_files
  validate :validate_number_of_album

  def validate_number_of_files
    return if images.length <= 15

    errors.add(:images, "に添付できる画像は15枚までです。")
  end

  def validate_number_of_album
    return if user.graduation_albums.length <= 2

    errors.add(:id, "作成できるアルバムは2つまでです。")
  end

  def register_images
    return if images.empty?

    image_ids = images.map(&:id)
    RegisterRekognitionJob.perform_later(image_ids)
  end
end
