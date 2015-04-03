class ChangeDescriptionToTextOnMedia < ActiveRecord::Migration
  def change
    change_column :media, :description, :text, :limit => 16777215
  end
end
