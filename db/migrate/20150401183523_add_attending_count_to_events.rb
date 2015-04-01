class AddAttendingCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :attending_count, :integer
    add_column :events, :stats_updated_at, :datetime
  end
end
