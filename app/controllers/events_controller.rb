class EventsController < ApplicationController
  before_action :authenticate_user!
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(set_event)
    if @event.save
      redirect_to graduation_album_event_path(@event.graduation_album, @event), notice: 'コメントを投稿しました'
    else
      flash.now['alert'] = 'イベント作成に失敗しました'
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
    @event_comments = @event.event_comments.order(created_at: :desc)
    @event_comment = EventComment.new
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_update_params)
      redirect_to graduation_album_event_path(@event.graduation_album, @event), notice: 'コメントを編集しました'
    else
      flash.now['alert'] = 'イベント編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy!
    redirect_to root_path
  end

  private

  def set_event
    params.require(:event).permit(:title, :description, :event_date, event_photos: []).merge(graduation_album_id: params[:graduation_album_id])
  end

  def event_update_params
    params.require(:event).permit(:title, :description, :event_date, event_photos: [])
  end
end
