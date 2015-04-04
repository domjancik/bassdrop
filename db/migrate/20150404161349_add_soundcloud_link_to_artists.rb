class AddSoundcloudLinkToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :link_soundcloud, :string
  end
end
