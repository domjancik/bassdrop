class ChangeDescriptionColumnTypeInEventsToText < ActiveRecord::Migration
  def change
    change_column :events, :description, :text, :limit => 16777215
  end
end
