class UsersController < ApplicationController
  def show
    @user = current_user
    @following_users = @user.followings
    @followed_users = @user.followers
  end
end
