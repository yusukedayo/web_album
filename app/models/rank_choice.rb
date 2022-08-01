# == Schema Information
#
# Table name: rank_choices
#
#  id            :bigint           not null, primary key
#  answers_count :integer          default(0)
#  content       :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rank_id       :bigint           not null
#
# Indexes
#
#  index_rank_choices_on_rank_id  (rank_id)
#
# Foreign Keys
#
#  fk_rails_...  (rank_id => ranks.id)
#
class RankChoice < ApplicationRecord
  has_one_attached :rank_choice_image
  belongs_to :rank
  has_many :answers, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }
end
