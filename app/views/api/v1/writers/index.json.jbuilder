json.data {json.array! @writers, partial: 'api/v1/writers/writer', as: :writer}
json.metadata do
  json.total_count @writers.length
  json.current_page @writers.current_page
  json.last_page @writers.total_pages
  json.page_size @writers.limit_value
end