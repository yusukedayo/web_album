class RemoveTitleFromGraduationAlbums < ActiveRecord::Migration[6.1]
  def up
    remove_column :graduation_albums, :title
  end

  def down
    add_column :graduation_albums, :title, :string
  end
end
