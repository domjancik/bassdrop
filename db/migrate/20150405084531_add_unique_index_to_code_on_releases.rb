class AddUniqueIndexToCodeOnReleases < ActiveRecord::Migration
  def change
    change_column :releases, :rel_code, :string, null: false
    add_index :releases, :rel_code, unique: true
  end
end
