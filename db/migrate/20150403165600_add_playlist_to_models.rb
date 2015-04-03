class AddPlaylistToModels < ActiveRecord::Migration
  def change
    add_reference :artists, :playlist, index: true
    add_foreign_key :artists, :playlists

    add_reference :events, :playlist, index: true
    add_foreign_key :events, :playlists

    add_reference :releases, :playlist, index: true
    add_foreign_key :releases, :playlists
  end
end
