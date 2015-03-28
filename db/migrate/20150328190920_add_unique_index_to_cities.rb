class AddUniqueIndexToCities < ActiveRecord::Migration
  def change
    add_index :cities, [:title, :country_id], unique: true
  end
end
