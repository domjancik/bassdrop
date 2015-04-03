class AddDescriptionToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :description, :text, :limit => 16777215
  end
end
