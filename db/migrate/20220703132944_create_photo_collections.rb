class CreatePhotoCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_collections do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
