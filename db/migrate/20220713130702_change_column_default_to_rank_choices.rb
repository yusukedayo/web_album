class ChangeColumnDefaultToRankChoices < ActiveRecord::Migration[6.1]
  def change
    change_column_default :rank_choices, :answers_count, from: nil, to: 0
  end
end
