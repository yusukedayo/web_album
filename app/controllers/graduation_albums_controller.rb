class GraduationAlbumsController < ApplicationController
  before_action :set_graduation_album, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  def index
    @graduation_albums = GraduationAlbum.all.order(created_at: :desc)
  end

  def show; end

  def new
    @graduation_album = GraduationAlbum.new
  end

  def create
    @graduation_album = current_user.graduation_albums.build(graduation_album_params)
    if @graduation_album.save
      redirect_to graduation_albums_path, notice: '作成に成功しました'
    else
      flash.now['alert'] = '作成に失敗しました'
      render :new
    end
  end

  def edit; end

  def update
    if @graduation_album.update(graduation_album_params)
      redirect_to graduation_albums_path, notice: '編集に成功しました'
    else
      flash.now['alert'] = '編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @graduation_album.destroy!
    redirect_to graduation_albums_path, notice: 'アルバムの削除に成功しました'
  end

  private

  def graduation_album_params 
    params.require(:graduation_album).permit(:album_name, :title)
  end

  def set_graduation_album
    @graduation_album = current_user.graduation_albums.find(params[:id])
  end
end
