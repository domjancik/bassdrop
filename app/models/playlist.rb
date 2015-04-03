class Playlist < ActiveRecord::Base
  validates :title, presence: true

  has_many :playlist_items
end
