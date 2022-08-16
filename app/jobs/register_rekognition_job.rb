class RegisterRekognitionJob < ApplicationJob
  include AwsRekognition
  queue_as :default

  def perform(image_ids)
    graduation_album_id = ActiveStorage::Attachment.find(image_ids.first).record_id
    graduation_album = GraduationAlbum.find(graduation_album_id)
    graduation_album.update_attribute(:analysis_status, 'doing')
    client = rekognition_client
    image_ids.each do |id|
      image = ActiveStorage::Attachment.find(id)
      resp = client.index_faces({
                                  collection_id: 'graduation_album',
                                  image: {
                                    s3_object: {
                                      bucket: 'aws-test-rails',
                                      name: image.key
                                    }
                                  }
                                })
      next if resp.to_h[:face_records] == []

      image_detail = PhotoPath.new(graduation_album_id: image.record_id, path: image.blob_id.to_s,
                                   image_id: resp.to_h[:face_records][0][:face][:image_id], s3_file_name: image.key)
      image_detail.save!
    end
    graduation_album.update_attribute(:analysis_status, 'done')
  end
end
