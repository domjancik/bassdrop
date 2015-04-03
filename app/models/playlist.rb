class Playlist < ActiveRecord::Base
  validates :title, presence: true

  has_many :items, class_name: 'PlaylistItem'
  has_many :media, through: :items

  has_many :artists
  has_many :events
  has_many :releases

  def self.create_for(model)
    title = "#{model.class.to_s} | #{model.title}"
    new_playlist = self.create title: title
    model.playlist = new_playlist
    model.save
    new_playlist
  end

  def to_s
    self.title
  end
end
