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
        visit graduation_albums_path
        click_button 'Follow'
        expect(page).to have_content 'ユーザーをフォローしました'
      end
    end
    describe 'フォローを解除できる' do
      it 'ユーザーのフォロー解除が成功する' do
        user
        other_user
        visit graduation_albums_path
        click_button 'Follow'
        click_button 'Unfollow'
        expect(page).to have_content 'ユーザーのフォローを解除しました'
      end
    end
  end
end
