json.array!(@credits) do |credit|
  json.extract! credit, :id, :title, :release_id, :artist_id, :list_order
  json.url credit_url(credit, format: :json)
end
