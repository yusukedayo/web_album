class AddEventPhotosToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :event_photos, :json
  end
end
