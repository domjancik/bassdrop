class AddCreatorTitleToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :creator_title, :string
  end
end
