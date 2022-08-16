class AutoMakeEventsController < ApplicationController
  before_action :authenticate_user!
  include AwsRekognition

  def create
    if GraduationAlbum.find(params[:graduation_album_id]).images_blobs.empty?
      flash[:danger] = 'アルバムに写真を追加してください'
      redirect_back(fallback_location: root_path)
    else
      having_face_images = PhotoPath.where(graduation_album_id: params[:graduation_album_id])
      client = rekognition_client
      having_face_images.each do |image|
        image = collect_happy_faces(image, client)
        image.save!
      end
      happy_photo_ids = PhotoPath.where(graduation_album_id: params[:graduation_album_id]).where('happy_score > ?', 90).pluck(:path).map(&:to_i)
      if happy_photo_ids.empty?
        flash[:danger] = 'イベントの作成に失敗しました 笑顔の写真を追加してください'
        redirect_back(fallback_location: root_path)
      else
        @event = Event.create!(title: 'みんなの笑顔集', description: 'アルバムに投稿された写真から笑顔の写真を抜粋しました！みんなの笑顔の写真を見て癒されましょう！', event_date: Date.today, user_id: current_user.id, graduation_album_id: params[:graduation_album_id])
        happy_photo_ids.each { |id| ActiveStorage::Attachment.create!(name: 'event_photos', record_type: 'Event', record_id: @event.id, blob_id: id) }
        redirect_to graduation_album_event_path(@event.graduation_album, @event), notice: 'イベントを作成しました'
      end
    end
  end
end
