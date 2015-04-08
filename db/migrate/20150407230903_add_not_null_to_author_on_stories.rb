class AddNotNullToAuthorOnStories < ActiveRecord::Migration
  def change
    change_column :stories, :author_id, :integer, null: false
  end
end
