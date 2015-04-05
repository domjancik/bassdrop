class AddUniqueIndexToUrlOnMedia < ActiveRecord::Migration
  def change
    change_column :media, :url, :string, null: false
    add_index :media, :url, unique: true
  end
end
