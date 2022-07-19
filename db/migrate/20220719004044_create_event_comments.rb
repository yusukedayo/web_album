class CreateEventComments < ActiveRecord::Migration[6.1]
  def change
    create_table :event_comments do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :active_storage_attachment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
