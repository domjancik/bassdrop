class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :title
      t.references :city, index: true

      t.timestamps null: false
    end
    add_foreign_key :artists, :cities
  end
end
