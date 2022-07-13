class AddAnswersCountToRankChoices < ActiveRecord::Migration[6.1]
  def change
    add_column :rank_choices, :answers_count, :integer
  end
end
