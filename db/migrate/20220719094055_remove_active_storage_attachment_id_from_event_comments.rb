class RemoveActiveStorageAttachmentIdFromEventComments < ActiveRecord::Migration[6.1]
  def up
    remove_column :event_comments, :active_storage_attachment_id
  end

  def down
    add_column :event_comments, :active_storage_attachment_id, null: false, foreign_key: true
  end
end
