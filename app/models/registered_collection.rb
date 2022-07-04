# == Schema Information
#
# Table name: registered_collections
#
#  id              :bigint           not null, primary key
#  collection_name :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_registered_collections_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class RegisteredCollection < ApplicationRecord
  belongs_to :user

  validates :collection_name, presence: true
  validates :collection_name, length: { maximum: 255 }
end
