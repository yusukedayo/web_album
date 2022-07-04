# == Schema Information
#
# Table name: photo_collections
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PhotoCollection < ApplicationRecord
  validates :name, presence: true
end
