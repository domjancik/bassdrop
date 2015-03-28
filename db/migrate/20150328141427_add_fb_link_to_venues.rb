class AddFbLinkToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :link_fb, :string

    add_index :venues, :link_fb, unique: true
  end
end
