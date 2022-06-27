class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :event_date
      t.references :user, null: false, foreign_key: true
      t.references :graduation_album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
