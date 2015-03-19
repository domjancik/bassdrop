json.array!(@artists) do |artist|
  json.extract! artist, :id, :title, :city_id
  json.url artist_url(artist, format: :json)
end
