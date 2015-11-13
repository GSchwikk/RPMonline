json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :name, :division
  json.url meeting_url(meeting, format: :json)
end
