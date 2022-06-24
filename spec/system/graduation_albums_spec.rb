# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraduationAlbums', type: :system do
  let(:user) { create(:user) }
  let(:graduation_album) { create(:graduation_album, user:) }
  let(:graduation_album_by_others) { create(:graduation_album) }
  describe 'ログイン後' do
    before do
      login_as(user)
    end

    describe 'アルバムの新規作成' do
      context 'フォームの入力値が正常' do
        it 'アルバムの新規作成が成功する' do
          visit new_graduation_album_path
          fill_in 'タイトル', with: 'test'
          fill_in 'アルバム名', with: 'test'
          click_button '作成する'
          expect(page).to have_content '作成に成功しました'
          expect(current_path).to eq graduation_albums_path
        end
      end

      context 'タイトルが未入力' do
        it 'アルバムの新規作成が失敗する' do
          visit new_graduation_album_path
          fill_in 'タイトル', with: nil
          fill_in 'アルバム名', with: 'test'
          click_button '作成する'
          expect(page).to have_content '作成に失敗しました'
          expect(current_path).to eq graduation_albums_path
        end
      end

      context 'アルバム名が未入力' do
        it 'アルバムの新規作成が失敗する' do
          visit new_graduation_album_path
          fill_in 'タイトル', with: 'test'
          fill_in 'アルバム名', with: nil
          click_button '作成する'
          expect(page).to have_content '作成に失敗しました'
          expect(current_path).to eq graduation_albums_path
        end
      end
    end

    describe 'アルバムの編集' do
      context 'フォームの入力値が正常' do
        it 'アルバムの編集が成功する' do
          graduation_album
          visit edit_graduation_album_path(graduation_album)
          fill_in 'アルバム名', with: 'after_edit'
          click_button '作成する'
          expect(page).to have_content '編集に成功しました'
          expect(current_path).to eq graduation_albums_path
        end
      end

      context 'タイトルがnil' do
        it 'アルバムの編集が失敗する' do
          graduation_album
          visit edit_graduation_album_path(graduation_album)
          fill_in 'タイトル', with: nil
          fill_in 'アルバム名', with: 'test'
          click_button '作成する'
          expect(current_path).to eq graduation_album_path(graduation_album)
        end
      end

      context 'タイトルがnil' do
        it 'アルバムの編集が失敗する' do
          graduation_album
          visit edit_graduation_album_path(graduation_album)
          fill_in 'タイトル', with: 'test'
          fill_in 'アルバム名', with: nil
          click_button '作成する'
          expect(current_path).to eq graduation_album_path(graduation_album)
        end
      end

      context '他のユーザーがアルバムを編集' do
        it 'アルバムの編集が失敗する' do
          graduation_album_by_others
          visit graduation_albums_path
          expect(page).not_to have_content '編集'
        end
      end
    end

    describe 'アルバムの削除' do
      context '作成ユーザーが自分のアルバムを削除' do
        it 'アルバムの削除が成功する' do
          graduation_album
          visit graduation_albums_path
          page.accept_confirm do
            click_on :delete_button
          end
          expect(current_path).to eq graduation_albums_path
        end
      end

      context '他のユーザーがアルバムを削除' do
        it 'アルバムの削除が失敗する' do
          graduation_album_by_others
          visit graduation_albums_path
          expect(page).not_to have_content '削除'
        end
      end
    end
  end
end
