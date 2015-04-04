class SetDefaultReleaseTypeForReleases < ActiveRecord::Migration
  def change
    change_column :releases, :release_type, :integer, default: 0, null: false, limit: 6
  end
end
