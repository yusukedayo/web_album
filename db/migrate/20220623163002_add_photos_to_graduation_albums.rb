class AddPhotosToGraduationAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :graduation_albums, :photos, :json
  end
end
