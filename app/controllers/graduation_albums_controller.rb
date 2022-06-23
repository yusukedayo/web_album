class GraduationAlbumsController < ApplicationController
  def index
    @graduation_albums = GraduationAlbum.all.order(created_at: :desc)
  end

  def show
    @graduation_album = GraduationAlbum.find(params[:id])
  end

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

  def edit
    @graduation_album = GraduationAlbum.find(params[:id])
  end

  def update
    graduation_album = GraduationAlbum.find(params[:id])
    if graduation_album.update(graduation_album_params)
      redirect_to graduation_albums_path, notice: '作成に成功しました'
    else
      flash.now['alert'] = '作成に失敗しました'
      render :edit
    end
  end

  def destroy
  graduation_album = GraduationAlbum.find(params[:id])
  graduation_album.destroy!
  redirect_to graduation_albums_path
end

  private

  def graduation_album_params 
    params.require(:graduation_album).permit(:album_name, :title)
  end
end
