class ChangeStateDefaultToSupriseMessages < ActiveRecord::Migration[6.1]
  def change
    change_column_default :suprise_messages, :state, from: nil, to: "0"
  end
end
