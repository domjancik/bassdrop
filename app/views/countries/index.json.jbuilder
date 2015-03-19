json.array!(@countries) do |country|
  json.extract! country, :id, :title, :abbreviation
  json.url country_url(country, format: :json)
end
