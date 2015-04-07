class AddCoverToEvents < ActiveRecord::Migration
  def change
    add_attachment :events, :cover
  end
end
