json.data {json.array! @crews, partial: 'api/v1/crews/crew', as: :crew}
json.metadata do
  json.total_count @crews.length
  json.current_page @crews.current_page
  json.last_page @crews.total_pages
  json.page_size @crews.limit_value
end