class AddMediumToPlaylistItems < ActiveRecord::Migration
  def change
    add_reference :playlist_items, :medium, index: true
    add_foreign_key :playlist_items, :media

    remove_column :playlist_items, :url
  end
end
