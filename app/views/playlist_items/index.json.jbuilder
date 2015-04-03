json.array!(@playlist_items) do |playlist_item|
  json.extract! playlist_item, :id, :playlist_id, :url, :list_order
  json.url playlist_item_url(playlist_item, format: :json)
end
