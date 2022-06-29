require 'rails_helper'

RSpec.describe "RankChoices", type: :system do
  let(:user) { create(:user) }
  let(:graduation_album) { create(:graduation_album, user:) }
  let(:rank) { create(:rank, user:, graduation_album:) }
  let(:rank_choice) { create(:rank_choice, rank:) }

  describe 'ログイン後' do
    before do
      login_as(user)
    end
    describe '選択肢の追加' do
      context '選択肢の入力値が正常' do
        it '選択肢の追加が成功する' do
          visit graduation_album_rank_path(graduation_album, rank)
          click_button '選択肢を追加'
          fill_in '選択肢', with: '作成した選択肢'
          click_button '作成する'
          expect(page).to have_content '作成した選択肢'
          expect(current_path).to eq graduation_album_rank_path(graduation_album, rank)
        end
      end
      context '選択肢が未入力' do
        it '選択肢の追加が失敗する' do
          visit graduation_album_rank_path(graduation_album, rank)
          click_button '選択肢を追加'
          fill_in '選択肢', with: nil
          click_button '作成する'
          expect(page).to have_content '選択肢を入力してください'
          expect(current_path).to eq graduation_album_rank_rank_choices_path(graduation_album, rank)
        end
      end
    end
    describe '選択肢の編集' do
      context '選択肢の入力値が正常' do
        it '選択肢の編集が成功する' do
          rank_choice
          visit edit_graduation_album_rank_rank_choice_path(graduation_album, rank, rank_choice)
          fill_in '選択肢', with: '編集後'
          click_button '作成する'
          expect(page).to have_content '編集後'
        end
      end
      context '選択肢が未入力' do
        it '選択肢の編集が失敗する' do
          rank_choice
          visit edit_graduation_album_rank_rank_choice_path(graduation_album, rank, rank_choice)
          fill_in '選択肢', with: nil
          click_button '作成する'
          expect(page).to have_content '選択肢を入力してください'
          graduation_album_rank_rank_choice_path(graduation_album, rank, rank_choice)
        end
      end
    end
    describe '選択肢の削除' do
      it 'イベントの削除が成功する' do
          rank_choice
          delete graduation_album_rank_rank_choice_path(graduation_album, rank, rank_choice)
        end
    end
  end
end
