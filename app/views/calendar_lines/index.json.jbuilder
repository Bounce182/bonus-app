json.array!(@calendar_lines) do |calendar_line|
  json.extract! calendar_line, :id, :user_id, :date
  json.url calendar_line_url(calendar_line, format: :json)
end
