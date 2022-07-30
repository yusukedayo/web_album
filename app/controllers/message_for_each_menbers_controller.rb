# frozen_string_literal: true

class MessageForEachMenbersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message_for_each_menber, only: %i[edit update destroy]

  def create
    @message_for_each_menber = current_user.message_for_each_menbers.build(message_for_each_menber_params)
    @message_for_each_menber.save
  end

  def edit; end

  def update
    if @message_for_each_menber.update(message_for_each_menber_update_params)
      redirect_to graduation_album_menber_path(@message_for_each_menber.graduation_album, @message_for_each_menber.to_user), notice: '編集に成功しました'
    else
      flash.now['alert'] = '編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @message_for_each_menber.destroy!
  end

  private

  def set_message_for_each_menber
    @message_for_each_menber = current_user.message_for_each_menbers.find(params[:id])
  end

  def message_for_each_menber_params
    params.require(:message_for_each_menber).permit(:body,
                                                    :to_user).merge(graduation_album_id: params[:graduation_album_id])
  end

  def message_for_each_menber_update_params
    params.require(:message_for_each_menber).permit(:body)
  end
end
