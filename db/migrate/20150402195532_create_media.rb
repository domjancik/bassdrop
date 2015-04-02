class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.string :url
      t.string :description

      t.timestamps null: false
    end
  end
end
