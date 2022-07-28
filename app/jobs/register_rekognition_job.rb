class RegisterRekognitionJob < ApplicationJob
  queue_as :default

  def perform(image_ids)
    credentials = Aws::Credentials.new(
      ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    )
    client = Aws::Rekognition::Client.new credentials: credentials
    unless PhotoCollection.find_by(name: 'graduation_album')
      client.create_collection({
                                collection_id: 'graduation_album'
                              })
      collection = PhotoCollection.new
      collection.name = 'graduation_album'
      collection.save
    end
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
                                  image_id: resp.to_h[:face_records][0][:face][:image_id])
      image_detail.save!
    end
  end
end
