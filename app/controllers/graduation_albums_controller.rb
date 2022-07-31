# frozen_string_literal: true

class GraduationAlbumsController < ApplicationController
  before_action :set_graduation_album, only: %i[update destroy]
  # before_action :authenticate_user!
  def index
    # @graduation_albums = current_user.belong_albums.order(created_at: :desc)
    @graduation_albums = GraduationAlbum.all
    @users = User.all
  end

  def show
    @graduation_album = GraduationAlbum.with_attached_images.find(params[:id])
    @message_for_everyones = @graduation_album.message_for_everyones.includes(:user).order(created_at: :desc)
    @message_for_everyone = MessageForEveryone.new
    @events = @graduation_album.events.with_attached_event_photos.order(created_at: :desc)
    @ranks = @graduation_album.ranks.order(created_at: :desc)
    @suprise_messages = @graduation_album.suprise_messages.includes(:user).order(created_at: :desc)
  end

  def new
    @graduation_album = GraduationAlbum.new
    set_search
  end

  def create
    set_search
    @graduation_album = current_user.graduation_albums.build(graduation_album_params)
    @graduation_album.users << current_user
    if @graduation_album.save
      if @graduation_album.images
        image_ids = @graduation_album.images.map(&:id)
        RegisterRekognitionJob.perform_later(image_ids)
      end
      redirect_to graduation_album_path(@graduation_album), notice: '作成に成功しました'
    else
      flash.now['alert'] = '作成に失敗しました'
      render :new
    end
  end

  def edit
    @graduation_album = current_user.graduation_albums.with_attached_images.find(params[:id])
  end

  def update
    if @graduation_album.update(graduation_album_params)
      @graduation_album.users << current_user
      redirect_to graduation_album_path(@graduation_album), notice: '編集に成功しました'
    else
      flash.now['alert'] = '編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @graduation_album.destroy!
    redirect_to graduation_albums_path, notice: 'アルバムの削除に成功しました'
  end

  def destroy_each_photo
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_to edit_graduation_album_path(image.record_id)
  end

  private

  def graduation_album_params
    params.require(:graduation_album).permit(:album_name, { user_ids: [] }, images: [])
  end

  def set_graduation_album
    @graduation_album = current_user.graduation_albums.find(params[:id])
  end
end
