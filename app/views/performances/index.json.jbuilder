json.array!(@performances) do |performance|
  json.extract! performance, :id, :event_id, :artist_id, :stage_id, :date_start, :date_end
  json.url performance_url(performance, format: :json)
end
