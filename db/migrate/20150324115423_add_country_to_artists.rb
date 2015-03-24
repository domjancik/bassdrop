class AddCountryToArtists < ActiveRecord::Migration
  def change
    add_reference :artists, :country, index: true
    add_foreign_key :artists, :countries
  end
end
