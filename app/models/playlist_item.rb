class PlaylistItem < ActiveRecord::Base
  default_scope { order 'list_order asc' }

  belongs_to :playlist
end
