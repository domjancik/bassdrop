class AddReleasedFlagToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :released_record, :boolean, default: false, null: false
  end
end
