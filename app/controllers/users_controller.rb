class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @following_users = @user.followings
    @followed_users = @user.followers
    set_search
  end
end
