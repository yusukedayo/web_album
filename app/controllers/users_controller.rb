class UsersController < ApplicationController
  def show
    @user = current_user
    @following_users = @user.followings
    @followed_users = @user.followers
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
