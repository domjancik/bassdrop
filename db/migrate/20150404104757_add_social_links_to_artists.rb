class AddSocialLinksToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :twitter_link, :string
    add_column :artists, :youtube_link, :string
    add_column :artists, :instagram_link, :string
  end
end
