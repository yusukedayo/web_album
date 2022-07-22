# == Schema Information
#
# Table name: events
#
#  id                  :bigint           not null, primary key
#  description         :text             not null
#  event_date          :date
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
class Event < ApplicationRecord
  has_many_attached :event_photos
  belongs_to :user
  belongs_to :graduation_album
  has_many :event_comments, dependent: :destroy

  validates :title, :description, :event_date, presence: true
  validates :title, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }
  FILE_NUMBER_LIMIT = 10
  validate :validate_number_of_files

  def validate_number_of_files
    return if :event_photos.length <= FILE_NUMBER_LIMIT
    errors.add(:event_photos, "に添付できる画像は#{FILE_NUMBER_LIMIT}件までです。")
  end
end
