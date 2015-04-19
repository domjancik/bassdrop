class AddAvatarToStories < ActiveRecord::Migration
  def change
    add_attachment :stories, :avatar
  end
end
