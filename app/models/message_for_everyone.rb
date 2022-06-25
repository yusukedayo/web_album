# frozen_string_literal: true

# == Schema Information
#
# Table name: message_for_everyones
#
#  id                  :bigint           not null, primary key
#  body                :text             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_message_for_everyones_on_graduation_album_id  (graduation_album_id)
#  index_message_for_everyones_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#  fk_rails_...  (user_id => users.id)
#
class MessageForEveryone < ApplicationRecord
  belongs_to :user
  belongs_to :graduation_album

  validates :body, presence: true, length: { maximum: 65_535 }
end
