class AddB2BPerformanceToPerformances < ActiveRecord::Migration
  def change
    add_reference :performances, :b2b, index: true
    add_foreign_key :performances, :performances, column: :b2b_id, on_delete: :nullify
  end
end
