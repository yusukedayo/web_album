class RemoveEventPhotosFromEvents < ActiveRecord::Migration[6.1]
  def up
    remove_column :events, :event_photos
  end

  def down
    add_column :events, :event_photos, :json
  end
end
