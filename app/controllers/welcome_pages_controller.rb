# frozen_string_literal: true

class WelcomePagesController < ApplicationController
  def top; end

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
    sign_in user
    redirect_to graduation_albums_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
