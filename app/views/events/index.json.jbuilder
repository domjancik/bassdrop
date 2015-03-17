json.array!(@events) do |event|
  json.extract! event, :id, :title, :date_start, :date_end, :preorder_url
  json.url event_url(event, format: :json)
end
