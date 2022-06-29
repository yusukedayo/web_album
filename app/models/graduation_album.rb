# frozen_string_literal: true

# == Schema Information
#
# Table name: graduation_albums
#
#  id         :bigint           not null, primary key
#  album_name :string           not null
#  photos     :json
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
  mount_uploaders :photos, PhotoUploader
  belongs_to :user
  has_many :message_for_everyones, dependent: :destroy
  has_many :message_for_each_menbers, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :ranks, dependent: :destroy
  has_many :album_users, dependent: :destroy
  has_many :users, through: :album_users, source: :user

  validates :title, :album_name, presence: true, length: { maximum: 255 }
end
