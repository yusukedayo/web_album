# frozen_string_literal: true

class GraduationAlbumsController < ApplicationController
  before_action :set_graduation_album, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  def index
    @graduation_albums = current_user.belong_albums.order(created_at: :desc)
    @users = User.all
  end

  def show
    @graduation_album = GraduationAlbum.find(params[:id])
    @message_for_everyones = @graduation_album.message_for_everyones.includes(:user).order(created_at: :desc)
    @message_for_everyone = MessageForEveryone.new
    @events = @graduation_album.events.order(created_at: :desc)
    @ranks = @graduation_album.ranks.order(created_at: :desc)
    @suprise_messages = @graduation_album.suprise_messages.order(created_at: :desc)
  end

  def new
    @graduation_album = GraduationAlbum.new
  end

  def create
    @graduation_album = current_user.graduation_albums.build(graduation_album_params)
    @graduation_album.users << current_user
    if @graduation_album.save
      if @graduation_album.photos
        num = @graduation_album.photos.size
        images = []
        photo_links = []
        num.times do |num|
          images.push(@graduation_album.photos[num].current_path)
          photo_links.push(@graduation_album.photos[num].identifier)
        end
        credentials = Aws::Credentials.new(
              ENV['AWS_ACCESS_KEY_ID'],
              ENV['AWS_SECRET_ACCESS_KEY']
            )
        client   = Aws::Rekognition::Client.new credentials: credentials
        unless PhotoCollection.find_by(name: @graduation_album.id)
          client.create_collection({
            collection_id: @graduation_album.id.to_s, 
          })
          collection = PhotoCollection.new
          collection.name = @graduation_album.id.to_s
          collection.save
        end
        images.each do |image|
          photo_links.each do |photo|
            image_detail = PhotoPath.new
            image_detail.graduation_album_id = @graduation_album.id
            resp = client.index_faces({
            collection_id: @graduation_album.id.to_s,
            image: {
              s3_object: {
                bucket: "aws-test-rails", 
                name: image, 
              }, 
            }, 
            })
            image_detail.path = photo
            image_detail.image_id = resp.to_h[:face_records][0][:face][:image_id]
            image_detail.save
          end
        end
      end
      redirect_to graduation_albums_path, notice: '作成に成功しました'
    else
      flash.now['alert'] = '作成に失敗しました'
      render :new
    end
  end

  def edit; end

  def update
    if @graduation_album.update(graduation_album_params)
      @graduation_album.users << current_user
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
    params.require(:graduation_album).permit(:album_name, :title, { photos: [] }, {user_ids: []})
  end

  def set_graduation_album
    @graduation_album = current_user.graduation_albums.find(params[:id])
  end
end
