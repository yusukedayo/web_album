# == Schema Information
#
# Table name: album_users
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_album_users_on_graduation_album_id  (graduation_album_id)
#  index_album_users_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#  fk_rails_...  (user_id => users.id)
#
class AlbumUser < ApplicationRecord
  belongs_to :graduation_album
  belongs_to :user
  validates :user_id, uniqueness: { scope: :graduation_album_id }
end
