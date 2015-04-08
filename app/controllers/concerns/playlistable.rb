module Playlistable extend ActiveSupport::Concern
  include GenericModelable

  # POST /<models>/:id/create_playlist
  def create_playlist
    playlist = Playlist.create_for model
    redirect_to playlist, notice: 'Playlist was successfully created.'
  end
end