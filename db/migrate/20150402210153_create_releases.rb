class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :title
      t.string :rel_code
      t.string :get_url
      t.string :get_text
      t.date :release_date
      t.integer :type, limit: 6

      t.timestamps null: false
    end
  end
end
