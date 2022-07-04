# == Schema Information
#
# Table name: photo_paths
#
#  id                  :bigint           not null, primary key
#  path                :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  image_id            :string           not null
#
# Indexes
#
#  index_photo_paths_on_graduation_album_id  (graduation_album_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#
class PhotoPath < ApplicationRecord
  belongs_to :graduation_album

  validates :path, :image_id, presence: true
end
