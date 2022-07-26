# frozen_string_literal: true

class MessageForEveryonesController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]
  before_action :set_message_for_everyone, only: %i[edit update destroy]

  def create
    @message_for_everyone = current_user.message_for_everyones.build(message_for_everyone_params)
    @message_for_everyone.save
  end

  def edit
    @graduation_album = GraduationAlbum.find(@message_for_everyone.graduation_album_id)
  end

  def update
    graduation_album = GraduationAlbum.find(@message_for_everyone.graduation_album_id)
    @message_for_everyone.update(message_for_everyone_update_params)
    redirect_to graduation_album_path(graduation_album), notice: 'コメントを編集しました'
  end

  def destroy
    @message_for_everyone.destroy!
  end

  private

  def set_message_for_everyone
    @message_for_everyone = current_user.message_for_everyones.find(params[:id])
  end

  def message_for_everyone_params
    params.require(:message_for_everyone).permit(:body).merge(graduation_album_id: params[:graduation_album_id])
  end

  def message_for_everyone_update_params
    params.require(:message_for_everyone).permit(:body)
  end
end
