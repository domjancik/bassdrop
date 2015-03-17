class AddVenueRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :venue, index: true
    add_foreign_key :events, :venues
  end
end
