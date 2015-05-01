class RemoveStringIdFromStories < ActiveRecord::Migration
  def change
    remove_index :stories, :id_string
    remove_column :stories, :id_string
  end
end
