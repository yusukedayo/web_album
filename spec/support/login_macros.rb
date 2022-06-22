# frozen_string_literal: true

module LoginMacros
  def login_as(user)
    visit login_path
    click_link 'ログイン'
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'ログイン'
  end
end
