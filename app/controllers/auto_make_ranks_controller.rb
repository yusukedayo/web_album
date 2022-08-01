class AutoMakeRanksController < ApplicationController
  def create
    if GraduationAlbum.find(params[:graduation_album_id]).images_blobs == []
      flash[:danger] = 'イベント作成するためには写真を追加してください'
      redirect_back(fallback_location: root_path)
    else
      # 既にhappy_scoreが設定されているものは除外する
      having_face_images = PhotoPath.where(graduation_album_id: params[:graduation_album_id]).where(happy_score: nil)
      if having_face_images
        credentials = Aws::Credentials.new(
          ENV.fetch('AWS_ACCESS_KEY_ID', nil),
          ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
        )
        client = Aws::Rekognition::Client.new credentials: credentials
        having_face_images.each do |image|
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
          number.times do |count|
            happy_score_count += result.to_h[:face_details][count][:emotions][0][:confidence].round
          end
          image.happy_score = happy_score_count
          image.save!
        end
      end
      happy_photos = PhotoPath.where(graduation_album_id: params[:graduation_album_id]).order(happy_score: 'DESC').limit(3)
      if happy_photos == []
        flash[:danger] = 'イベントの作成に失敗しました 笑顔の写真を追加してください'
        redirect_back(fallback_location: root_path)
      else
        @rank = Rank.create!(rank_title: 'ハッピー写真ランキング', rank_description: 'アルバムに投稿された写真から笑顔の写真を抜粋しました！みんなの笑顔の写真を見て癒されましょう！', user_id: current_user.id, graduation_album_id: params[:graduation_album_id])
        happy_photos.each do |photo|
          rank_choice = RankChoice.create!(content: "#{photo.happy_score}点の笑顔です！", rank_id: @rank.id)
          ActiveStorage::Attachment.create!(name: 'rank_choice_image', record_type: 'RankChoice', record_id: rank_choice.id, blob_id: photo.path.to_i)
        end
        redirect_to graduation_album_rank_path(@rank.graduation_album, @rank), notice: 'イベントを作成しました'
      end
    end
  end
end
