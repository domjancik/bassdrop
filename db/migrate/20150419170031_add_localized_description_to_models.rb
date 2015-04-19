class AddLocalizedDescriptionToModels < ActiveRecord::Migration
  def change
    add_column :artists, :description_cs, :text, limit: 16777215
    add_column :events, :description_cs, :text, limit: 16777215
    add_column :releases, :description_cs, :text, limit: 16777215
    add_column :stories, :description_cs, :text, limit: 16777215
    add_column :stories, :title_cs, :string
  end
end
