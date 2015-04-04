class RenameTypeColumnOnReleases < ActiveRecord::Migration
  def change
    rename_column :releases, :type, :release_type
  end
end
