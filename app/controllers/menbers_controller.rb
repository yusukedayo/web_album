# frozen_string_literal: true

class MenbersController < ApplicationController
  def show
    @menber = User.find(params[:id])
    @graduation_album = GraduationAlbum.find(params[:graduation_album_id])
    @message_for_each_menbers = @graduation_album.message_for_each_menbers.where(to_user: @menber.id).includes(:user).order(created_at: :desc)
    @message_for_each_menber = MessageForEachMenber.new
  end
end
