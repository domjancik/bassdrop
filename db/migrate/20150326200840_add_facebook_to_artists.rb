class AddFacebookToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :link_fb, :string
  end
end
