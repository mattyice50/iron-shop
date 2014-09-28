json.array! @items do |item|
  json.title item.title
  json.price item.price
  json.description item.description
end
