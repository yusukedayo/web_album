require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'バリデーション' do
    it 'ユーザーidとfollow_idが存在する場合有効であること' do
      relationship = build(:relationship)
      expect(relationship).to be_valid
      expect(relationship.errors).to be_empty
    end
  end
end
