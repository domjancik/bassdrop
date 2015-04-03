class RemoveReleaseMedia < ActiveRecord::Migration
  def change
    drop_table :release_media
  end
end
