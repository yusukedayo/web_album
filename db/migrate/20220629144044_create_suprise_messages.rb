class CreateSupriseMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :suprise_messages do |t|
      t.references :graduation_album, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :suprise_title, null: false
      t.text :suprise_message, null: false
      t.date :suprise_time, null: false
      t.integer :state, null: false, defalut: 0

      t.timestamps
    end
  end
end
