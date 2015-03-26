class AddImageCachingToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :image_url_cached_at, :datetime
    add_column :artists, :image_url_cached, :string
  end
end
