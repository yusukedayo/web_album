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
require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'user_id、answer_id、rank_choice_idが存在する場合有効であること' do
    answer = build(:answer)
    expect(answer).to be_valid
    expect(answer.errors).to be_empty
  end
end
