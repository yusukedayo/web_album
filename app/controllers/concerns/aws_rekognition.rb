module AwsRekognition
  extend ActiveSupport::Concern

  def rekognition_client
    credentials = Aws::Credentials.new(
      ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    )
    Aws::Rekognition::Client.new credentials:
  end

  def collect_happy_faces(image, client)
    attrs = {
      image: {
        s3_object: {
          bucket: 'aws-test-rails',
          name: image.s3_file_name
        }
      },
      attributes: ['ALL']
    }
    result = client.detect_faces attrs
    number = if result.to_h[:face_details].length > 5
               5
             else
               result.to_h[:face_details].length
             end
    happy_score_count = 0
    number.times { |count| happy_score_count += result.to_h[:face_details][count][:emotions][0][:confidence].round }
    image.happy_score = happy_score_count
    image
  end

  def collect_menber_faces(menber)
    client = rekognition_client
    face_id = menber.face_id
    collection_id = 'graduation_album'
    client.search_faces({
                          collection_id:,
                          face_id:,
                          face_match_threshold: 90,
                          max_faces: 10
                        })
  end
end
