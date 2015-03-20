class AddHeadlinerFlagToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :is_headliner, :boolean
  end
end
