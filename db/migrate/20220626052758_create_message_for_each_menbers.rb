class CreateMessageForEachMenbers < ActiveRecord::Migration[6.1]
  def change
    create_table :message_for_each_menbers do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :graduation_album, null: false, foreign_key: true
      t.integer :to_user, null: false

      t.timestamps
    end
  end
end
