class AddEventIdToEventComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :event_comments, :event, null: false, foreign_key: true
  end
end
