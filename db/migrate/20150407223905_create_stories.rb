class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.text :description
      t.references :release, index: true
      t.references :artist, index: true
      t.references :event, index: true
      t.references :playlist, index: true
      t.references :author, index: true
      t.datetime :published_at
      t.boolean :published, default: false

      t.timestamps null: false
    end
    add_foreign_key :stories, :releases
    add_foreign_key :stories, :artists
    add_foreign_key :stories, :events
    add_foreign_key :stories, :playlists
    add_foreign_key :stories, :artists, column_name: :author_id
  end
end
