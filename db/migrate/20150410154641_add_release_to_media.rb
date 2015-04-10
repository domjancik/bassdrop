class AddReleaseToMedia < ActiveRecord::Migration
  def change
    add_reference :media, :release, index: true
    add_foreign_key :media, :releases
  end
end
