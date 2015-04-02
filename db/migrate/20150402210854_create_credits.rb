class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string :title
      t.references :release, index: true
      t.references :artist, index: true
      t.integer :list_order

      t.timestamps null: false
    end
    add_foreign_key :credits, :releases
    add_foreign_key :credits, :artists
  end
end
