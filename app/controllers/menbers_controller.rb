# frozen_string_literal: true

class MenbersController < ApplicationController
  def show
    @menber = User.find(params[:id])
    @graduation_album = GraduationAlbum.find(params[:graduation_album_id])
    collection_id = @graduation_album.id.to_s
    if @menber.face_id && @menber.registered_collections.pluck(:collection_name).include?(collection_id.to_s)
      credentials = Aws::Credentials.new(
        ENV.fetch('AWS_ACCESS_KEY_ID', nil),
        ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
      )
      client = Aws::Rekognition::Client.new credentials: credentials
      face_id = @menber.face_id
      resp = client.search_faces({
                                   collection_id:,
                                   face_id:,
                                   face_match_threshold: 90,
                                   max_faces: 10
                                 })
      if resp
        num = resp[:face_matches].size
        mathed_faces = []
        num.times do |num|
          mathed_faces.push(resp[:face_matches][num][:face][:image_id])
        end
        @mathed_face_images = []
        mathed_faces.each do |image|
          photo_path = PhotoPath.where(graduation_album_id: @graduation_album.id).where(image_id: image).first
          @mathed_face_images.push(ActiveStorage::Attachment.where(record_id: @graduation_album.id).where(blob_id: photo_path.path.to_i).first)
        end
      end
    end
    @message_for_each_menbers = @graduation_album.message_for_each_menbers.where(to_user: @menber.id).includes(:user).order(created_at: :desc)
    @message_for_each_menber = MessageForEachMenber.new
    @ranks = @menber.ranks.includes([:graduation_album])
    @suprise_messages = @menber.suprise_messages.includes([:graduation_album])
    @events = @menber.events.with_attached_event_photos.includes([:graduation_album])
  end
end
