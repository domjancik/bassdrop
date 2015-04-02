json.array!(@media) do |medium|
  json.extract! medium, :id, :title, :url, :description
  json.url medium_url(medium, format: :json)
end
