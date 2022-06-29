require 'rails_helper'

RSpec.describe "Ranks", type: :system do
  let(:user) { create(:user) }
  let(:graduation_album) { create(:graduation_album, user:) }
  let(:rank) { create(:rank, user:, graduation_album:) }

  describe 'ログイン後' do
    before do
      login_as(user)
    end
    describe 'ランキングの新規作成' do
      context 'ランキングの入力値が正常' do
        it 'ランキングの新規作成が成功する' do
          visit graduation_album_path(graduation_album)
          click_button 'ランキングを作成'
          fill_in 'タイトル', with: 'ランキング'
          fill_in '詳細', with: 'ランキングの詳細'
          click_button '作成する'
          expect(page).to have_content 'ランキング'
          expect(page).to have_content 'ランキングの詳細'
        end
      end
      context 'タイトルが未入力' do
        it 'ランキングの新規作成が失敗する' do
          visit graduation_album_path(graduation_album)
          click_button 'イベントを作成'
          click_button '作成する'
          fill_in 'タイトル', with: nil
          fill_in '詳細', with: 'ランキングの詳細'
          click_button '作成する'
          expect(page).to have_content '作成に失敗しました'
        end
      end
    end
    describe 'イベントの編集' do
      context 'イベントの入力値が正常' do
        it 'イベントの編集が成功する' do
          rank
          visit graduation_album_rank_path(graduation_album, rank)
          click_link '編集'
          fill_in 'タイトル', with: '編集後'
          click_button '作成する'
          expect(page).to have_content '編集後'
        end
      end
      context 'タイトルが未入力' do
        it 'イベントの編集が成功する' do
          rank
          visit graduation_album_rank_path(graduation_album, rank)
          click_link '編集'
          fill_in 'タイトル', with: nil
          click_button '作成する'
          expect(page).to have_content 'タイトル'
          expect(page).to have_content '詳細'
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
    describe 'イベントの削除' do
      it 'イベントの削除が成功する' do
          rank
          visit graduation_album_rank_path(graduation_album, rank)
          page.accept_confirm do
            click_on :delete_button
          end
          expect(current_path).to eq root_path
        end
    end
  end
end