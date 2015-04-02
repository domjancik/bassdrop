class CreateReleaseMedia < ActiveRecord::Migration
  def change
    create_table :release_media do |t|
      t.references :release, index: true
      t.references :medium, index: true
      t.integer :list_order

      t.timestamps null: false
    end
    add_foreign_key :release_media, :releases
    add_foreign_key :release_media, :media
  end
end
