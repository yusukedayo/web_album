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
class MessageForEachMenber < ApplicationRecord
  belongs_to :user
  belongs_to :graduation_album

  validates :body, presence: true, length: { maximum: 65535 }
end
