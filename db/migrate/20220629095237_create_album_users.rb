class CreateAlbumUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :album_users do |t|
      t.references :graduation_album, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
