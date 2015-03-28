class AddFbLinkUniqueIndexToArtists < ActiveRecord::Migration
  def change
    add_index :artists, :link_fb, unique: true
  end
end
