json.array!(@costs) do |cost|
  json.extract! cost, :id, :buyday, :item, :spendmoney
  json.url cost_url(cost, format: :json)
end
