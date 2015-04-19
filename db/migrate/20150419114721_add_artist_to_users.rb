class AddArtistToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :artist, index: true
    add_foreign_key :users, :artists
  end
end
