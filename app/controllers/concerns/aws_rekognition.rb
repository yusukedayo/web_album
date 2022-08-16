module AwsRekognition
  extend ActiveSupport::Concern

  def rekognition_client
    credentials = Aws::Credentials.new(
      ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    )
    client = Aws::Rekognition::Client.new credentials: credentials
    return client
  end
end