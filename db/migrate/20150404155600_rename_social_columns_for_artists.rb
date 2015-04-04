# Rename new social columns for artists so they are more consistent with link_fb

class RenameSocialColumnsForArtists < ActiveRecord::Migration
  def change
    rename_column :artists, :twitter_link, :link_twitter
    rename_column :artists, :youtube_link, :link_youtube
    rename_column :artists, :instagram_link, :link_instagram
  end
end
