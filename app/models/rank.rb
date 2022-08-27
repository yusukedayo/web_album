# == Schema Information
#
# Table name: ranks
#
#  id                  :bigint           not null, primary key
#  rank_description    :text             not null
#  rank_title          :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  graduation_album_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_ranks_on_graduation_album_id  (graduation_album_id)
#  index_ranks_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (graduation_album_id => graduation_albums.id)
#  fk_rails_...  (user_id => users.id)
#
class Rank < ApplicationRecord
  belongs_to :user
  belongs_to :graduation_album
  has_many :rank_choices, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :rank_title, :rank_description, presence: true
  validates :rank_title, length: { maximum: 40 }
  validates :rank_description, length: { maximum: 250 }
end
