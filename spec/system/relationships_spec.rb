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
      xit 'ユーザーのフォローが成功する' do
        user
        other_user
        visit users_show_path
        click_button 'Follow'
        expect(page).to have_content 'UNFOLLOW'
      end
    end
    describe 'フォローを解除できる' do
      xit 'ユーザーのフォロー解除が成功する' do
        user
        other_user
        visit users_show_path
        click_button 'Follow'
        click_button 'UNFOLLOW'
        expect(page).to have_content 'Follow'
      end
    end
  end
end
