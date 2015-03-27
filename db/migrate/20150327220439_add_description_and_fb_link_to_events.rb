class AddDescriptionAndFbLinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :description, :string
    add_column :events, :link_fb, :string

    add_index :events, :link_fb, unique: true
  end
end
