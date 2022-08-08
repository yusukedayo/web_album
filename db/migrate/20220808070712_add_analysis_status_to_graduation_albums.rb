class AddAnalysisStatusToGraduationAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :graduation_albums, :analysis_status, :integer, null: false, default: 0
  end
end
