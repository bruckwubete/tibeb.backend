json.data {json.array! @actors, partial: 'api/v1/actors/actor', as: :actor}
json.metadata do
  json.total_count @actors.length
  json.current_page @actors.current_page
  json.last_page @actors.total_pages
  json.page_size @actors.limit_value
end