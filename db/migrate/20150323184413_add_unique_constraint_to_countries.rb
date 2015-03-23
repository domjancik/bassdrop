class AddUniqueConstraintToCountries < ActiveRecord::Migration
  def change
    add_index(:countries, :title, :unique => true)
    add_index(:countries, :abbreviation, :unique => true)
  end
end
