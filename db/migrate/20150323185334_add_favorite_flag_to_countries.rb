class AddFavoriteFlagToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :favorite, :boolean, :default => false
  end
end
