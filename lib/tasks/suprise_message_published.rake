namespace :suprise_message_published do
  desc '1日おきに記事をチェックして公開すべきサプライズメッセージがあれば公開ステータスを変更する'
  task suprise_message_published: :environment do
    @suprise_messages = SupriseMessage.where(state: 'publish_wait').where('suprise_time <= ?', Date.today)
		@suprise_messages.each do |message|
			message.state = 'published'
      message.save!
    end
  end
end
