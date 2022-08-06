# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MessageForEachMenbers', type: :system do
  let(:user) { create(:user) }
  let(:graduation_album) { create(:graduation_album, user:) }
  let(:message_for_everyone) { create(:message_for_everyone, user:, graduation_album:) }
  describe 'ログイン後' do
    before do
      login_as(user)
      graduation_album.users << user
    end
    describe '個別メッセージの新規作成' do
      context '個別メッセージの入力値が正常' do
        it '個別メッセージの新規作成が成功する' do
          visit graduation_album_menber_path(graduation_album, user)
          fill_in 'js-new-message_for_each_menber-body', with: 'メッセージテスト'
          click_button '作成する'
          visit graduation_album_menber_path(graduation_album, user)
          expect(page).to have_content 'メッセージテスト'
        end
      end
      context 'bodyが未入力' do
        it '個別メッセージの新規作成が失敗する' do
          visit graduation_album_menber_path(graduation_album, user)
          fill_in 'js-new-message_for_each_menber-body', with: nil
          click_button '作成する'
          expect(current_path).to eq graduation_album_menber_path(graduation_album, user)
        end
      end
    end
  end
end
