class RenameCreatorTitleToTeamTitleOnArtists < ActiveRecord::Migration
  def change
    rename_column :artists, :creator_title, :team_title
  end
end
