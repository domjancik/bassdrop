class AddAvatarToReleases < ActiveRecord::Migration
  def change
    add_attachment :releases, :avatar
  end
end
