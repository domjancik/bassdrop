class AddFeaturedFlagToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :featured, :boolean, null: false, default: false
  end
end
