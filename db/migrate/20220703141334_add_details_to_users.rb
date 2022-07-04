class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar, :string
    add_column :users, :face_id, :string
  end
end
