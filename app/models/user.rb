# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  avatar                 :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  face_id                :string
#  social_unique_id       :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :graduation_albums, dependent: :destroy
  has_many :message_for_everyones, dependent: :destroy
  has_many :message_for_each_menbers, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :ranks, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :album_users, dependent: :destroy
  has_many :belong_albums, through: :album_users, source: :graduation_album
  has_many :suprise_messages, dependent: :destroy
  has_many :registered_collections, dependent: :destroy
  has_many :event_comments, dependent: :destroy

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def own?(object)
    id == object.user_id
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
