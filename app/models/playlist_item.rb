class PlaylistItem < ActiveRecord::Base
  # TODO validate unique order in playlist

  default_scope { order 'list_order asc' }

  validates :playlist, presence: true
  validates :medium, presence: true

  belongs_to :playlist
  belongs_to :medium

  def next
    playlist.items.where('list_order > ?', list_order).first
  end

  def prev
    playlist.items.where('list_order < ?', list_order).last
  end
end
