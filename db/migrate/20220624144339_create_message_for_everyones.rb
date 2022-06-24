class CreateMessageForEveryones < ActiveRecord::Migration[6.1]
  def change
    create_table :message_for_everyones do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :graduation_album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
