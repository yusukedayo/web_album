# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'メールアドレス・パスワード・名前全て存在し、パスワードは3字以上、名は255字以内の場合有効であること' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'メールアドレスが無い場合不正であること' do
      user_without_email = build(:user, email: nil)
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to include('を入力してください')
    end

    it 'メールアドレスがユニークでなければ不正であること' do
      user_one = create(:user)
      user_another = build(:user, email: user_one.email)
      expect(user_another).to be_invalid
      expect(user_another.errors[:email]).to include('はすでに存在します')
    end

    it 'パスワードが無い場合不正であること' do
      user_without_password = build(:user, password: nil)
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to include('を入力してください')
    end

    it 'パスワードが6字以上の場合不正であること' do
      user_with_two_character_password = build(:user, password: 'ab')
      expect(user_with_two_character_password).to be_invalid
      expect(user_with_two_character_password.errors[:password]).to include('は6文字以上で入力してください')
    end

    it '名前が無い場合不正であること' do
      user_without_name = build(:user, name: nil)
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to include('を入力してください')
    end

    it '名前が255文字の場合有効であること' do
      user_with_255_character_name = build(:user, name: 'a' * 255)
      expect(user_with_255_character_name).to be_valid
      expect(user_with_255_character_name.errors).to be_empty
    end

    it '名前が256文字の場合不正であること' do
      user_without_name = build(:user, name: 'a' * 256)
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ['は255文字以内で入力してください']
    end
  end
end
