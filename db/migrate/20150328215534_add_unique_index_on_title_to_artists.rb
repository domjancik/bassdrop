class AddUniqueIndexOnTitleToArtists < ActiveRecord::Migration
  def change
    add_index :artists, :title, unique: true
  end
end
