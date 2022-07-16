class RemovePhotosFromGrasuationAlbums < ActiveRecord::Migration[6.1]
  def up
    remove_column :graduation_albums, :photos
  end

  def down
    add_column :graduation_albums, :photos, :json
  end
end
