json.array!(@releases) do |release|
  json.extract! release, :id, :title, :rel_code, :get_url, :get_text, :release_date, :type
  json.url release_url(release, format: :json)
end
