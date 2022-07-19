crumb :root do
  link 'Home', graduation_albums_path
end

crumb :graduation_album_new do
  link 'アルバム作成', new_graduation_album_path
  parent :root
end

crumb :graduation_album_edit do |graduation_album|
  link 'アルバム編集', edit_graduation_album_path(graduation_album)
  parent :root
end

crumb :graduation_album do |graduation_album|
  link graduation_album.album_name.to_s, graduation_album_path(graduation_album)
  parent :root
end

crumb :menber_show do |graduation_album, menber|
  link "#{menber.name}さんの詳細"
  parent :graduation_album, graduation_album
end

crumb :event_show do |graduation_album, event|
  link event.title.to_s
  parent :graduation_album, graduation_album
end

crumb :rank_show do |graduation_album, rank|
  link rank.rank_title.to_s
  parent :graduation_album, graduation_album
end

crumb :suprise_show do |graduation_album, suprise_message|
  link suprise_message.suprise_title.to_s
  parent :graduation_album, graduation_album
end
