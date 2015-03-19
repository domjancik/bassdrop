json.array!(@stages) do |stage|
  json.extract! stage, :id, :title, :venue_id
  json.url stage_url(stage, format: :json)
end
