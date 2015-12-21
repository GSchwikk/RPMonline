json.array!(@organisations) do |organisation|
  json.extract! organisation, :id, :name, :industry, :image
  json.url organisation_url(organisation, format: :json)
end
