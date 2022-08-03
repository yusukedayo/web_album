require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:graduation_album) { create(:graduation_album, user:) }

  describe 'ログイン後' do
    before do
      login_as(user)
    end
    describe 'ユーザーをフォローできる' do
      it 'ユーザーのフォローが成功する' do
        user
        other_user
        visit users_show_path
        click_button 'Follow'
        user.followings.length == 1
      end
    end
    describe 'フォローを解除できる' do
      it 'ユーザーのフォロー解除が成功する' do
        user
        other_user
        visit new_graduation_album_path
        click_button 'Follow'
        click_button 'Unfollow'
        user.followings.length == 0
      end
    end
  end
end
