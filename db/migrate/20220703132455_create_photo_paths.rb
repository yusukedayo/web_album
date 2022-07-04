class CreatePhotoPaths < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_paths do |t|
      t.references :graduation_album, null: false, foreign_key: true
      t.string :path, null: false
      t.string :image_id, null: false

      t.timestamps
    end
  end
end
