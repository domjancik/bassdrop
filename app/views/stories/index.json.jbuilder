json.array!(@stories) do |story|
  json.extract! story, :id, :title, :description, :release_id, :artist_id, :event_id, :playlist_id, :author_id, :published_at, :published
  json.url story_url(story, format: :json)
end
