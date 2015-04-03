class Playlist < ActiveRecord::Base
  validates :title, presence: true

  has_many :playlist_items

  has_many :artists
  has_many :events
  has_many :releases
end
