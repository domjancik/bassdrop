json.array!(@release_media) do |release_medium|
  json.extract! release_medium, :id, :release_id, :medium_id, :list_order
  json.url release_medium_url(release_medium, format: :json)
end
