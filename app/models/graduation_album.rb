# == Schema Information
#
# Table name: graduation_albums
#
#  id         :bigint           not null, primary key
#  album_name :string           not null
#  title      :string           not null
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
class GraduationAlbum < ApplicationRecord
  belongs_to :user

  validates :title, :album_name, presence: true
end