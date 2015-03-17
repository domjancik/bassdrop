json.array!(@venues) do |venue|
  json.extract! venue, :id, :title, :address, :url
  json.url venue_url(venue, format: :json)
end
