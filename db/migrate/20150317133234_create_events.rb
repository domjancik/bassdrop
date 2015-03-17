class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date_start
      t.datetime :date_end
      t.string :preorder_url

      t.timestamps null: false
    end
  end
end
