class AddFlagsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :published, :boolean, default: false, null: false
    add_column :events, :automatic_updates, :boolean, default: true, null: false
  end
end
