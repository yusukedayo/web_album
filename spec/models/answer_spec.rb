require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'user_id、answer_id、rank_choice_idが存在する場合有効であること' do
    answer = build(:answer)
    expect(answer).to be_valid
    expect(answer.errors).to be_empty
  end
end
