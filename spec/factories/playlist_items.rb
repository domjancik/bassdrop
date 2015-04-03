FactoryGirl.define do
  factory :playlist_item do
    playlist do
      Playlist.find_by(title: 'TestPlaylist') || FactoryGirl.create(:playlist)
    end
    url "TestItem"
    list_order 1
  end

end
