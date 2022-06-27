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
  belongs_to :user
  belongs_to :graduation_album

  validates :title, :description, presence: true
  validates :title, length: { maximum: 255 }
  validates :description, length: { maximum: 65535 }
end