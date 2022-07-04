class CreateRegisteredCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :registered_collections do |t|
      t.references :user, null: false, foreign_key: true
      t.string :collection_name, null: false

      t.timestamps
    end
  end
end
