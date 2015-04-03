class CreatePlaylistItems < ActiveRecord::Migration
  def change
    create_table :playlist_items do |t|
      t.references :playlist, index: true
      t.string :url
      t.integer :list_order

      t.timestamps null: false
    end
    add_foreign_key :playlist_items, :playlists
  end
end
