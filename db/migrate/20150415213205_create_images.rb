class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :description
      t.attachment :image

      t.timestamps null: false
    end

    add_index(:images, :title, :unique => true)
  end
end
