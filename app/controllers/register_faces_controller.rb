class RegisterFacesController < ApplicationController
  before_action :authenticate_user!
  include AwsRekognition

  def create
    user = User.find(params[:menber_id])
    graduation_album = GraduationAlbum.find(params[:graduation_album_id])
    if user.avatar
      avatar_path = user.avatar.current_path
      if avatar_path.nil?
        redirect_to graduation_album_menber_path(graduation_album, user), notice: 'プロフィール画像をデフォルトから変更してください'
      else
        collection_id = 'graduation_album'
        client = rekognition_client
        resp = client.index_faces({
                                    collection_id:,
                                    image: {
                                      s3_object: {
                                        bucket: 'aws-test-rails',
                                        name: avatar_path
                                      }
                                    }
                                  })
        if resp[:face_records] == []
          redirect_to graduation_album_menber_path(graduation_album, user), notice: '人物の顔がはっきり写っているかを確認してください'
        else
          user.register_face_id(resp)
          redirect_to graduation_album_menber_path(graduation_album, user), notice: '同じ人物の画像を取得しました'
        end
      end
    else
      redirect_to graduation_album_menber_path(graduation_album, user), alert: 'プロフィール画像を設定してください'
    end
  end
end
