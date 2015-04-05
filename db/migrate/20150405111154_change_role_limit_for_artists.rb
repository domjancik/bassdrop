class ChangeRoleLimitForArtists < ActiveRecord::Migration
  def change
    change_column :artists, :role, :integer, limit: 5
  end
end
