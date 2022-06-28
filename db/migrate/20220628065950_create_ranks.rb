class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.string :rank_title, null: false
      t.text :rank_description, null: false
      t.references :user, null: false, foreign_key: true
      t.references :graduation_album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
