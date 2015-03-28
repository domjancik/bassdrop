class AddRoleToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :role, :integer, default: 0, limit: 4
  end
end
