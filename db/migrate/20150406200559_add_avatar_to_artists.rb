class AddAvatarToArtists < ActiveRecord::Migration
  def change
    add_attachment :artists, :avatar
  end
end
