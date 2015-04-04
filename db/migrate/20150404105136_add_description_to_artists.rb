class AddDescriptionToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :description, :text, :limit => 16777215
  end
end
