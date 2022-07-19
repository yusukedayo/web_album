class EventCommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]
  before_action :set_event_comment, only: %i[edit update destroy]

  def create
    @event_comment = current_user.event_comments.build(event_comment_params)
    @event_comment.save
  end

  def edit; end

  def update
    @event_comment.update(event_comment_update_params)
    redirect_to graduation_album_event_path(@event_comment.event.graduation_album, @event_comment.event)
  end

  def destroy
    @event_comment.destroy!
  end

  private

  def set_event_comment
    @event_comment = current_user.event_comments.find(params[:id])
  end

  def event_comment_params
    params.require(:event_comment).permit(:body).merge(event_id: params[:event_id])
  end

  def event_comment_update_params
    params.require(:event_comment).permit(:body)
  end
end
