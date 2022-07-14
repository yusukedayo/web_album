# == Schema Information
#
# Table name: suprise_messages
#
#  id                  :bigint           not null, primary key
#  state               :integer          default("publish_wait"), not null
#  suprise_message     :text             not null
#  suprise_time        :date             not null
#  suprise_title       :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_suprise_messages_on_graduation_album_id  (graduation_album_id)
#  index_suprise_messages_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#  fk_rails_...  (user_id => users.id)
#
class SupriseMessage < ApplicationRecord
  belongs_to :graduation_album
  belongs_to :user

  enum state: { publish_wait: 0, published: 1 }
  validates :suprise_title, :suprise_message, :suprise_time, presence: true
  validates :suprise_title, length: { maximum: 255 }
  validates :suprise_message, length: { maximum: 65_535 }
end
