class CreateRankChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :rank_choices do |t|
      t.string :content, null: false
      t.references :rank, null: false, foreign_key: true

      t.timestamps
    end
  end
end
