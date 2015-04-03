class PlaylistItem < ActiveRecord::Base
  default_scope { order 'list_order asc' }

  validates :playlist, presence: true
  validates :medium, presence: true

  belongs_to :playlist
  belongs_to :medium
end
