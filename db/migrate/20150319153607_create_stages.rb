class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :title
      t.references :venue, index: true

      t.timestamps null: false
    end
    add_foreign_key :stages, :venues
  end
end
