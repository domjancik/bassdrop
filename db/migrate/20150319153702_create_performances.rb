class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.references :event, index: true
      t.references :artist, index: true
      t.references :stage, index: true
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps null: false
    end
    add_foreign_key :performances, :events
    add_foreign_key :performances, :artists
    add_foreign_key :performances, :stages
  end
end
