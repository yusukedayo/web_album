# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー新規作成' do
    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        visit '/signup'
        fill_in 'name', with: 'test_name'
        fill_in 'email', with: 'test@example.com'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button '登録'
        #expect(page).to have_content 'ユーザー登録が完了'
        expect(current_path).to eq root_path
      end
    end

    context '名前が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit '/signup'
        fill_in 'name', with: nil
        fill_in 'email', with: 'test@example.com'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button '登録'
        #expect(page).to have_content 'ユーザー登録に失敗しました'
        #expect(page).to have_content '姓を入力してください'
        expect(current_path).to eq '/users'
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit '/signup'
        fill_in 'name', with: nil
        fill_in 'email', with: 'test@example.com'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button '登録'
       #expect(page).to have_content 'ユーザー登録に失敗しました'
       #expect(page).to have_content 'メールアドレスを入力してください'
        expect(current_path).to eq '/users'
      end
    end

    context '登録済のメールアドレスを使用' do
      it 'ユーザーの新規作成が失敗する' do
        user = create(:user)
        visit '/signup'
        fill_in 'name', with: nil
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button '登録'
        #expect(page).to have_content 'ユーザー登録に失敗しました'
        #expect(page).to have_content 'メールアドレスはすでに存在します'
        expect(current_path).to eq '/users'
        #expect(page).to have_field 'メールアドレス', with: user.email
      end
    end
  end

  describe 'ログイン前' do
    context 'メールアドレス、パスワードが入力されており、既存のユーザーのものと一致した場合' do
      it 'ログインが成功する' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        #expect(page).to have_content 'ログインしました'
        expect(current_path).to eq root_path
      end
    end

    context 'メールアドレスが未入力の場合' do
      it 'ログインが失敗する' do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        #expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq "/users/sign_in"
      end
    end

    context 'パスワードが未入力の場合' do
      it 'ログインが失敗する' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: ''
        click_button 'ログイン'
        #expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq "/users/sign_in"
      end
    end

    context 'フォームが未入力の場合' do
      it 'ログインが失敗する' do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        click_button 'ログイン'
        #expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq "/users/sign_in"
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリックする' do
      it 'ログアウトが完了する' do
        login_as(user)
        find_by_id('profile').click
        click_on 'ログアウト'
        #expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq root_path
      end
    end
  end
end
