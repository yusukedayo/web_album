class RegisterFacesController < ApplicationController
  def create
    user = User.find(params[:menber_id])
    graduation_album = GraduationAlbum.find(params[:graduation_album_id])
    if user.avatar
      avatar_path = user.avatar.current_path
      if avatar_path == nil
        redirect_to graduation_album_menber_path(graduation_album, user), notice: 'プロフィール画像をデフォルトから変更してください' 
      else
        collection_id = GraduationAlbum.find(params[:graduation_album_id]).id.to_s
        credentials = Aws::Credentials.new(
          ENV.fetch('AWS_ACCESS_KEY_ID', nil),
          ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
        )
        client = Aws::Rekognition::Client.new credentials: credentials
        resp = client.index_faces({
                                    collection_id:,
                                    image: {
                                      s3_object: {
                                        bucket: 'aws-test-rails',
                                        name: avatar_path
                                      }
                                    }
                                  })
        unless user.face_id = resp[:face_records] == []
          user.face_id = resp[:face_records][0][:face][:face_id]
          user.save!
          registered_collection = RegisteredCollection.new(user_id: user.id, collection_name: collection_id)
          registered_collection.save!
          redirect_to graduation_album_menber_path(graduation_album, user), notice: '同じ人物の画像を取得しました'
        else
          redirect_to graduation_album_menber_path(graduation_album, user), notice: '人物の顔がはっきり写っているかを確認してください'
        end
      end
    else
      redirect_to graduation_album_menber_path(graduation_album, user), alert: 'プロフィール画像を設定してください'
    end
  end
end
