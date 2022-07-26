require 'rails_helper'

RSpec.describe "Events", type: :system do
  let(:user) { create(:user) }
  let(:graduation_album) { create(:graduation_album, user:) }
  let(:message_for_everyone) { create(:message_for_everyone, user:, graduation_album:) }
  let(:event) { create(:event, user:, graduation_album:) }
  describe 'ログイン後' do
    before do
      login_as(user)
    end
    describe 'イベントの新規作成' do
      context 'イベントの入力値が正常' do
        it 'イベントの新規作成が成功する' do
          visit graduation_album_path(graduation_album)
          click_button 'イベントを作成'
          fill_in 'タイトル', with: 'イベントテスト'
          fill_in '詳細', with: 'イベントのテスト'
          click_button '作成する'
          expect(page).to have_content 'イベントテスト'
        end
      end
      context 'bodyが未入力' do
        it 'イベントの新規作成が失敗する' do
          visit graduation_album_path(graduation_album)
          click_button 'イベントを作成'
          click_button '作成する'
          fill_in 'タイトル', with: nil
          fill_in '詳細', with: 'イベントのテスト'
          click_button '作成する'
          expect(page).to have_content '作成に失敗しました'
        end
      end
    end
    xdescribe 'イベントの編集' do
      context 'イベントの入力値が正常' do
        it 'イベントの編集が成功する' do
          event
          visit graduation_album_path(graduation_album)
          click_link '編集'
          fill_in 'タイトル', with: 'イベントテスト(編集後)'
          fill_in '詳細', with: 'イベントのテスト'
          click_button '作成する'
          expect(page).to have_content 'イベントテスト(編集後)'
        end
      end
      context 'タイトルが未入力' do
        it 'イベントの編集が失敗する' do
          event
          visit graduation_album_path(graduation_album)
          click_link '編集'
          fill_in 'タイトル', with: nil
          fill_in '詳細', with: 'イベントのテスト'
          click_button '作成する'
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
    describe 'イベントの削除' do
      it 'イベントの削除が成功する' do
          event
          visit graduation_album_path(graduation_album)
          page.accept_confirm do
            click_on :delete_button
          end
          visit graduation_album_path(graduation_album)
          expect(page).to have_no_content 'イベントタイトル5'
      end
    end
  end
end
