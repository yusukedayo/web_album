class SupriseMessagesController < ApplicationController
  def new
    @suprise_message = SupriseMessage.new
  end
  
  def create
    @suprise_message = current_user.suprise_messages.build(set_suprise_message)
    if @suprise_message.save
      redirect_to graduation_album_path(@suprise_message.graduation_album), notice: 'サプライズメッセージを投稿しました'
    else 
      flash.now['alert'] = 'サプライズメッセージ作成に失敗しました'
      render :new
    end
  end
  
  def edit
    @suprise_message = SupriseMessage.find(params[:id])
  end
  
  def show
    @suprise_message = SupriseMessage.find(params[:id])
  end
  
  def update
    @suprise_message = SupriseMessage.find(params[:id])
    if @suprise_message.update(set_suprise_message)
      redirect_to graduation_album_path(@suprise_message.graduation_album), notice: 'サプライズメッセージを編集しました'
    else
      flash.now['alert'] = 'サプライズメッセージ編集に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @suprise_message = SupriseMessage.find(params[:id])
    @suprise_message.destroy!
    redirect_to graduation_album_path(@suprise_message.graduation_album)
  end
  
  private
  
  def set_suprise_message
    params.require(:suprise_message).permit(:suprise_title, :suprise_message, :suprise_time, :state).merge(graduation_album_id: params[:graduation_album_id])
  end
end
