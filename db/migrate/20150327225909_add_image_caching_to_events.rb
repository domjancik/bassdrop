class AddImageCachingToEvents < ActiveRecord::Migration
  def change
    add_column :events, :cached_at, :datetime
    add_column :events, :image_url_cached, :string
  end
end
