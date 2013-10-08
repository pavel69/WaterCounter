json.array!(@counters) do |counter|
  json.extract! counter, :date, :warm, :cold
  json.url counter_url(counter, format: :json)
end
