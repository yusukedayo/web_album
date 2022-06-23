class CreateGraduationAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :graduation_albums do |t|
      t.string :title, null: false
      t.string :album_name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
