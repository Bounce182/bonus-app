json.array!(@fragments) do |fragment|
  json.extract! fragment, :id, :calendar_line, :amount
  json.url fragment_url(fragment, format: :json)
end
