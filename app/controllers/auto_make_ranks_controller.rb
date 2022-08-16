class AutoMakeRanksController < ApplicationController
  include AwsRekognition

  def create
    if GraduationAlbum.find(params[:graduation_album_id]).images_blobs == []
      flash[:danger] = 'イベント作成するためには写真を追加してください'
      redirect_back(fallback_location: root_path)
    else
      # 既にhappy_scoreが設定されているものは除外する
      having_face_images = PhotoPath.where(graduation_album_id: params[:graduation_album_id]).where(happy_score: nil)
      if having_face_images
        client = rekognition_client
        having_face_images.each do |image|
          image = collect_happy_faces(image, client)
          image.save!
        end
      end
      happy_photos = PhotoPath.where(graduation_album_id: params[:graduation_album_id]).order(happy_score: 'DESC').where('happy_score > ?', 90).limit(3)
      if happy_photos == []
        flash[:danger] = 'イベントの作成に失敗しました 幸せそうな写真を追加してください'
        redirect_back(fallback_location: root_path)
      else
        @rank = Rank.create!(rank_title: '幸せな写真ランキング', rank_description: 'アルバムに投稿された写真から幸福度の高い写真を抜粋しました！みんなの幸せな顔を見て癒されましょう！', user_id: current_user.id, graduation_album_id: params[:graduation_album_id])
        happy_photos.each do |photo|
          rank_choice = RankChoice.create!(content: '最高の笑顔です！', rank_id: @rank.id)
          ActiveStorage::Attachment.create!(name: 'rank_choice_image', record_type: 'RankChoice', record_id: rank_choice.id, blob_id: photo.path.to_i)
        end
        redirect_to graduation_album_rank_path(@rank.graduation_album, @rank), notice: 'イベントを作成しました'
      end
    end
  end
end
