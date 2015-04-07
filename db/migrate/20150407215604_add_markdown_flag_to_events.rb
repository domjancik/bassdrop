class AddMarkdownFlagToEvents < ActiveRecord::Migration
  def change
    add_column :events, :markdown_enabled, :boolean, default: false, null: false
  end
end
