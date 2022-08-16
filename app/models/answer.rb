# == Schema Information
#
# Table name: answers
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  rank_choice_id :bigint           not null
#  rank_id        :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_answers_on_rank_choice_id  (rank_choice_id)
#  index_answers_on_rank_id         (rank_id)
#  index_answers_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (rank_choice_id => rank_choices.id)
#  fk_rails_...  (rank_id => ranks.id)
#  fk_rails_...  (user_id => users.id)
#
class Answer < ApplicationRecord
  belongs_to :rank_choice, counter_cache: true
  belongs_to :rank
  belongs_to :user

  def answer_count(rank, rank_choice, user_id)
    self.rank_id = rank.id
    self.rank_choice_id = rank_choice.id
    self.user_id = user_id
    self.save!
  end
end
