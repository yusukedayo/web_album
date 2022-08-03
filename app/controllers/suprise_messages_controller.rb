class SupriseMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rank, only: %i[update destroy edit show]
  def new
    @suprise_message = SupriseMessage.new
  end

  def create
    @suprise_message = current_user.suprise_messages.build(params_suprise_message)
    if @suprise_message.save
      redirect_to graduation_album_path(@suprise_message.graduation_album), notice: 'サプライズメッセージを投稿しました'
    else
      flash.now['alert'] = 'サプライズメッセージ作成に失敗しました'
      render :new
    end
  end

  def edit;end

  def show;end

  def update
    if @suprise_message.update(params_suprise_message)
      redirect_to graduation_album_path(@suprise_message.graduation_album), notice: 'サプライズメッセージを編集しました'
    else
      flash.now['alert'] = 'サプライズメッセージ編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @suprise_message.destroy!
    redirect_to graduation_album_path(@suprise_message.graduation_album)
  end

  private

  def params_suprise_message
    params.require(:suprise_message).permit(:suprise_title, :suprise_message, :suprise_time,
                                            :state).merge(graduation_album_id: params[:graduation_album_id])
  end

  def set_suprise_message
    @suprise_message = current_user.suprise_messages.find(params[:id])
  end
end
