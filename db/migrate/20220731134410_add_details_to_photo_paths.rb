class AddDetailsToPhotoPaths < ActiveRecord::Migration[6.1]
  def change
    add_column :photo_paths, :s3_file_name, :string
    add_column :photo_paths, :happy_score, :integer
  end
end
